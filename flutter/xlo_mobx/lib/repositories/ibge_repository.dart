import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo_mobx/models/city.dart';
import 'package:xlo_mobx/models/uf.dart';

class IbgeRepository {
  Future<List<Uf>?> getUfList() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('UF_LIST')) {
      final value = json.decode(preferences.getString('UF_LIST')!);
      return value?.map<Uf>((e) => Uf.fromJson(e)).toList()
        ?..sort(
          (Uf a, Uf b) =>
              a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
        );
    }

    const endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(endpoint);

      preferences.setString('UF_LIST', json.encode(response.data));

      return response.data?.map<Uf>((e) => Uf.fromJson(e)).toList()
        ?..sort(
          (Uf a, Uf b) =>
              a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
        );
    } on DioError {
      return Future.error('Falha ao obter lista de estados');
    }
  }

  Future<List<City>?> getCityListFromApi(Uf uf) async {
    final endpoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';

    try {
      final response = await Dio().get<List>(endpoint);

      return response.data?.map<City>((e) => City.fromJson(e)).toList()
        ?..sort(
          (City a, City b) =>
              a.name!.toLowerCase().compareTo(b.name!.toLowerCase()),
        );
    } on DioError {
      return Future.error('Falha ao obter lista de cidades');
    }
  }
}

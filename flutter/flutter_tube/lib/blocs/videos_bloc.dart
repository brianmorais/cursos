import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_tube/api.dart';
import 'package:flutter_tube/models/video.dart';

class VideosBloc extends BlocBase {
  Api api;
  List<Video> videos;

  VideosBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }

  final StreamController<List<Video>> _videosController =
      StreamController<List<Video>>();
  final StreamController<String> _searchController = StreamController<String>();

  Stream get outVideos => _videosController.stream;
  Sink get inSearch => _searchController.sink;

  void _search(String search) async {
    if (search != null) {
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    super.dispose();
    _videosController.close();
    _searchController.close();
  }
}

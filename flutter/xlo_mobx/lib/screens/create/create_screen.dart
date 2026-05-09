import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/screens/create/components/hide_phone_field.dart';
import 'package:xlo_mobx/screens/create/components/images_field.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'components/category_field.dart';
import 'components/cep_field.dart';

class CreateScreen extends StatelessWidget {
  final CreateStore createStore = CreateStore();
  @override
  Widget build(BuildContext context) {
    final TextStyle _labelStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.grey,
      fontSize: 18,
    );

    final _contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Anúncio'),
        centerTitle: true,
      ),
      drawer: CustomDrawer(),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImagesField(createStore),
                Observer(
                  builder: (_) => TextFormField(
                    onChanged: createStore.setTitle,
                    decoration: InputDecoration(
                      errorText: createStore.titleError,
                      contentPadding: _contentPadding,
                      labelText: 'Título *',
                      labelStyle: _labelStyle,
                    ),
                  ),
                ),
                Observer(
                  builder: (_) => TextFormField(
                    onChanged: createStore.setDescription,
                    decoration: InputDecoration(
                      errorText: createStore.descriptionError,
                      contentPadding: _contentPadding,
                      labelText: 'Descrição *',
                      labelStyle: _labelStyle,
                    ),
                    maxLines: null,
                  ),
                ),
                CategoryField(createStore),
                CepField(createStore),
                Observer(
                  builder: (_) => TextFormField(
                    onChanged: createStore.setPrice,
                    decoration: InputDecoration(
                      errorText: createStore.priceError,
                      contentPadding: _contentPadding,
                      labelText: 'Proço *',
                      labelStyle: _labelStyle,
                      prefixText: 'R\$ ',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true),
                    ],
                  ),
                ),
                HidePhoneField(createStore),
                Observer(
                  builder: (_) => SizedBox(
                    height: 50,
                    child: GestureDetector(
                      onTap: createStore.invalidSendPressed,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                            (states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.orange.withAlpha(120);
                              } else {
                                return Colors.orange;
                              }
                            },
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed:
                            createStore.formValid ? createStore.send : null,
                        child: Text(
                          'Enviar',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

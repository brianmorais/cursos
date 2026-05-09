import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/product_bloc.dart';
import 'package:gerente_loja/validators/product_validator.dart';
import 'package:gerente_loja/widgets/images_widget.dart';
import 'package:gerente_loja/widgets/product_sizes.dart';

class ProductScreen extends StatefulWidget {
  final String categoryId;
  final DocumentSnapshot product;

  ProductScreen({@required this.categoryId, this.product});

  @override
  _ProductScreenState createState() => _ProductScreenState(categoryId, product);
}

class _ProductScreenState extends State<ProductScreen> with ProductValidator {
  _ProductScreenState(String categoryId, DocumentSnapshot product)
      : _productBloc = ProductBloc(categoryId: categoryId, product: product);

  final ProductBloc _productBloc;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _fieldStyle = TextStyle(color: Colors.white, fontSize: 16);

    InputDecoration _buildDecoration(String label) {
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
      );
    }

    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        title: StreamBuilder<bool>(
          stream: _productBloc.outCreated,
          initialData: false,
          builder: (context, snapshot) {
            return Text(snapshot.data ? 'Editar Produto' : 'Criar Produto');
          },
        ),
        actions: [
          StreamBuilder<bool>(
            stream: _productBloc.outCreated,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return StreamBuilder<bool>(
                  stream: _productBloc.outLoading,
                  initialData: false,
                  builder: (context, snapshot) {
                    return IconButton(
                      onPressed: snapshot.data
                          ? null
                          : () {
                              _productBloc.deleteProduct();
                              Navigator.of(context).pop();
                            },
                      icon: Icon(Icons.remove),
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
          StreamBuilder<bool>(
            stream: _productBloc.outLoading,
            initialData: false,
            builder: (context, snapshot) {
              return IconButton(
                onPressed: snapshot.data ? null : saveProduct,
                icon: Icon(Icons.save),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: StreamBuilder<Map>(
              stream: _productBloc.outData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Container();
                return ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    Text(
                      'Imagens',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    ImagesWidget(
                      context: context,
                      initialValue: snapshot.data['images'],
                      onSaved: _productBloc.saveImages,
                      validator: validateImages,
                    ),
                    TextFormField(
                      initialValue: snapshot.data['title'],
                      style: _fieldStyle,
                      decoration: _buildDecoration('Título'),
                      onSaved: _productBloc.saveTitle,
                      validator: validateTitle,
                    ),
                    TextFormField(
                      initialValue: snapshot.data['description'],
                      style: _fieldStyle,
                      maxLines: 6,
                      decoration: _buildDecoration('Descrição'),
                      onSaved: _productBloc.saveDescription,
                      validator: validateDescription,
                    ),
                    TextFormField(
                      initialValue: snapshot.data['price']?.toStringAsFixed(2),
                      style: _fieldStyle,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: _buildDecoration('Preço'),
                      onSaved: _productBloc.savePrice,
                      validator: validatePrice,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ProductSizes(
                      context: context,
                      initialValue: snapshot.data['sizes'],
                      onSaved: _productBloc.saveSizes,
                      validator: validateSizes,
                    ),
                  ],
                );
              },
            ),
          ),
          StreamBuilder<bool>(
            stream: _productBloc.outLoading,
            initialData: false,
            builder: (context, snapshot) {
              return IgnorePointer(
                ignoring: !snapshot.data,
                child: Container(
                  color: snapshot.data ? Colors.black54 : Colors.transparent,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void saveProduct() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      ScaffoldMessenger.of(_scaffoldkey.currentContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.pinkAccent,
          content: Text(
            'Salvando o produto',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(minutes: 1),
        ),
      );

      bool success = await _productBloc.saveProduct();

      ScaffoldMessenger.of(_scaffoldkey.currentContext).removeCurrentSnackBar();

      ScaffoldMessenger.of(_scaffoldkey.currentContext).showSnackBar(
        SnackBar(
          backgroundColor: Colors.pinkAccent,
          content: Text(
            success ? 'Produto salvo!' : 'Erro ao salvar produto',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/error_box.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {
  final Category? selected;
  final bool showAll;
  final CategoryStore _categoryStore = GetIt.I<CategoryStore>();
  CategoryScreen({this.selected, this.showAll = true});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.fromLTRB(32, 12, 32, 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Observer(
            builder: (_) {
              if (_categoryStore.error.isNotEmpty) {
                return ErrorBox(message: _categoryStore.error);
              } else if (_categoryStore.categoryList.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final categories = showAll
                    ? _categoryStore.allCategoryList
                    : _categoryStore.categoryList;
                return ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder: (_, __) {
                    return Divider(
                      height: 0.1,
                      color: Colors.grey,
                    );
                  },
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop(category);
                      },
                      child: Container(
                        height: 50,
                        color: category.id == selected?.id
                            ? Colors.purple.withAlpha(50)
                            : null,
                        child: Text(
                          category.description!,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: category.id == selected?.id
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                        alignment: Alignment.center,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

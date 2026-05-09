import 'package:mobx/mobx.dart';
import 'package:todo_mobx/stores/todo_store.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  @observable
  String newTodoTitle = '';

  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void setTodoTitle(String value) => newTodoTitle = value;

  @action
  void addTodo() {
    todoList.insert(0, TodoStore(newTodoTitle));
    newTodoTitle = '';
  }

  @computed
  bool get newTodoTitleIsEmpty => newTodoTitle.isNotEmpty;
}

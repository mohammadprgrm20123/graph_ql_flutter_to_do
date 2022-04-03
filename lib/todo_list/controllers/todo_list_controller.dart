import 'package:get/get.dart';

import '../../share/models/todo_view_model.dart';

class ToDoListController extends GetxController {
  RxList<ToDoViewModel> listToDo = <ToDoViewModel>[].obs;

  String queryOfTodoList = r"""
  query {
    todos{
    id
    is_completed,
    is_public,
    title,
    created_at
  }
} """;

  static String addTodo =
  '''mutation addTodo(\$title: String!, \$isPublic: Boolean!) {
 action: insert_todos(objects: { title: \$title, is_public: \$isPublic }) {
    returning {
     id
     title
     is_completed
   }
 }
 }''';

  String deleteTodoMutation() {
    return r"""
  mutation delete_todo($id: Int!){
    delete_todos_by_pk(id: $id){
    is_completed
  }
}
""";
  }

  List<ToDoViewModel> convertList({required List<dynamic> dynamicList}) {
    List<ToDoViewModel> listToDo = [];
    for (var element in dynamicList) {
      listToDo.add(ToDoViewModel.fromJson(element));
    }
    return listToDo;
  }
}

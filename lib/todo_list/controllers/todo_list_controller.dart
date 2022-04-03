import 'package:get/get.dart';
import 'package:graph_ql_2/todo_list/models/todo_view_model.dart';

class ToDoListController extends GetxController {


  List<ToDoViewModel> listToDo = [];

  String queryOfTodoList = """
  query {
    todos{
    id
    is_completed,
    is_public,
    title,
    created_at
  }
} """;


  List<ToDoViewModel> convertList({required List<dynamic> dynamicList}){

    List<ToDoViewModel> listToDo = [];
    for (var element in dynamicList) {
      listToDo.add(ToDoViewModel.fromJson(element));
    }
    return listToDo;

  }

}

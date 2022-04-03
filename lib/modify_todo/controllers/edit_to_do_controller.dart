import 'package:get/get.dart';
import 'package:graph_ql_2/share/models/todo_view_model.dart';
import 'package:graphql/src/core/query_result.dart';

import 'base_modify_todo_controller.dart';

class EditToDoController extends BaseModifyToDoController {
  @override
  void setData({required QueryResult result}) {

    ToDoViewModel toDoViewModel = ToDoViewModel.fromJson(result.data!['update_todos_by_pk']);
    Get.back(result: toDoViewModel,);

  }

  EditToDoController({required final this.toDoViewModel});

  ToDoViewModel toDoViewModel;

  @override
  void onInit() {
    textButten = 'edit';
    modifyMutation = ''' 
    mutation edit(\$id: Int!,\$title : String!){
  update_todos_by_pk(pk_columns: {id: \$id},_set:{title:\$title}) {
    id
    title
  }
}
    
    ''';

    toDoTextController.text = toDoViewModel.title!;
    checkbox.value = toDoViewModel.isPublic!;
    super.onInit();

  }

  @override
  Map<String, dynamic> setMapForRunMutation() {

    return {
      'title': toDoTextController.text,
      'id' :toDoViewModel.id
    };
  }
}

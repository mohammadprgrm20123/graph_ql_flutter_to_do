
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../share/models/todo_view_model.dart';
import 'base_modify_todo_controller.dart';

class AddToDoController extends BaseModifyToDoController{


@override
  void onInit() {
    super.onInit();
    modifyMutation = '''
  mutation insert(\$title: String!,\$is_public : Boolean!) {
  insert_todos_one(object: {title: \$title, is_public: \$is_public}){
    id
    created_at
    title
    is_public
  }
}
   ''';
  }

  @override
  void setData({required QueryResult result}) {
    ToDoViewModel toDoViewModel = ToDoViewModel.fromJson(result.data!['insert_todos_one']);
    Get.back(result: toDoViewModel);
  }

  @override
  Map<String, dynamic> setMapForRunMutation() {

    return {
      'title': toDoTextController.text,
      'is_public': checkbox.value
    };
  }

}
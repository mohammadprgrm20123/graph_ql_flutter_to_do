import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_ql_2/todo_list/controllers/todo_list_controller.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../share/models/todo_view_model.dart';

class DeleteDialogToDo extends GetView<ToDoListController> {
  final ToDoViewModel toDoViewModel;

  const DeleteDialogToDo({Key? key, required final this.toDoViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: const Text(
        'delete this item?',
        style: TextStyle(fontSize: 13),
      ),
      actions: [
        Mutation(
            options: MutationOptions(
              onError: (onValue){
                print('error');
              },
              onCompleted: (onValue){
                print('delete to do');
                Get.back();
                controller.listToDo.removeWhere((element) => element.id==toDoViewModel.id);
              },
                document: gql(controller.deleteTodoMutation())),
            builder: (MultiSourceResult<dynamic> Function(
                        Map<String, dynamic>,
                        {Object? optimisticResult})
                    runMutation,
                result) {
              if (result!.isLoading) {
                return const CircularProgressIndicator();
              }
              if (result.hasException) {
                Get.snackbar('', 'has error');
              }

              print(result.toString());

              return TextButton(
                child: const Text('delete'),
                onPressed: () {
                  runMutation({'id': toDoViewModel.id});
                },
              );
            }),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_ql_2/api_client.dart';
import 'package:graph_ql_2/todo_list/controllers/todo_list_controller.dart';
import 'package:graph_ql_2/todo_list/views/delete_dialog_todo.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../add_todo/views/add_to_do_dialog.dart';
import '../../share/models/todo_view_model.dart';

class ListTodoPage extends GetView<ToDoListController> {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ToDoListController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
            title: 'insert new to do',
            content: const AddToDoDialog()
          ).then((value) {
            if(value!=null){
              if(value is ToDoViewModel){
                controller.listToDo.insert(0,value,);
              }
            }

          });

        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('To Do List')),
      body: Scaffold(
        body: Query(
          options: QueryOptions(document: gql(controller.queryOfTodoList)),
          builder: (QueryResult result, {refetch, FetchMore? fetchMore}) {
            if (result.isLoading) {
              return loding();
            }

            if (result.hasException) {
              return error();
            }
            controller.listToDo.value =
                controller.convertList(dynamicList: result.data!['todos']);
            return body();
          },
        ),
      ),
    );
  }

  Widget error() {
    return const Center(
              child: Text('has Error'),
            );
  }

  Center loding() {
    return const Center(
              child: CircularProgressIndicator(),
            );
  }

  Widget body() => Obx(() =>ListView(
            children: controller.listToDo.map((e) => item(e)).toList()));

  Widget item(ToDoViewModel e) {
    return Card(
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('title: ${e.title}'),
            Text('date created: ${e.createdAt}'),
            Text('public: ${e.isPublic}'),
          ],
        ),
        trailing: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.dialog(DeleteDialogToDo(
                  toDoViewModel: e,
                ));
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            const Icon(
              Icons.edit,
              color: Colors.blueAccent,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_ql_2/todo_list/controllers/todo_list_controller.dart';
import 'package:graph_ql_2/todo_list/models/todo_view_model.dart';
import 'package:graph_ql_2/todo_list/views/delete_dialog.dart';
import 'package:graph_ql_2/api_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ListTodoPage extends GetView<ToDoListController> {
  const ListTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ToDoListController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('To Do List')),
      body: GraphQLProvider(
        client: ApiClient.createClient(),
        child: Scaffold(
          body: Query(
            options: QueryOptions(document: gql(controller.queryOfTodoList)),
            builder: (QueryResult result, {refetch, FetchMore? fetchMore}) {
              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (result.hasException) {
                return const Center(
                  child: Text('has Error'),
                );
              }
              controller.listToDo =
                  controller.convertList(dynamicList: result.data!['todos']);
              return body();
            },
          ),
        ),
      ),
    );
  }

  Widget body() =>
      ListView(
          children: controller.listToDo
              .map((e) => item(e))
              .toList());

  Widget item(ToDoViewModel e) {
    return Card(child: ListTile(
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
            onTap: (){
              Get.dialog(const DeleteDialog());
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

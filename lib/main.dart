

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_ql_2/graph_ql_provider.dart';
import 'package:graph_ql_2/todo_list/views/list_todo_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';


void main() async {
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClientProvider(
      child: const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: ListTodoPage(),
      ),
    );
  }
}

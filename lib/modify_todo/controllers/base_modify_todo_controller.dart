

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class BaseModifyToDoController extends GetxController {


  RxBool checkbox = true.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController toDoTextController = TextEditingController();

  String modifyMutation = '';
  String textButten = 'create';


  void setData({required QueryResult result});

  Map<String, dynamic> setMapForRunMutation();
}

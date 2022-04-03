
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddToDoController extends GetxController{

  RxBool checkbox =true.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController toDoTextController = TextEditingController();




  String insertMutation = '''
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_ql_2/share/models/todo_view_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../controllers/add_todo_controller.dart';

class AddToDoDialog extends GetView<AddToDoController> {
  const AddToDoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddToDoController());

    return Mutation(
      options: MutationOptions(
          document: gql(controller.insertMutation)),
      builder: (MultiSourceResult<dynamic> Function(Map<String, dynamic>,
                  {Object? optimisticResult})
              insert,
          QueryResult<dynamic>? result) {
        print(result.toString());


        if(result?.data !=null){

          ToDoViewModel toDoViewModel = ToDoViewModel.fromJson(result!.data!['insert_todos_one']);
          Get.back(result: toDoViewModel);
        }

        return Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'this filed shouldnt empty ';
                  }
                },
                controller: controller.toDoTextController,
                keyboardType: TextInputType.text,
                maxLines: 1,
                decoration: const InputDecoration(
                    labelText: 'text todo',
                    hintMaxLines: 1,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.green, width: 4.0))),
              ),
              Row(
                children: [
                  const Text('is public :'),
                  Obx(() {
                    return Checkbox(
                        value: controller.checkbox.value,
                        onChanged: (value) {
                          controller.checkbox.value = value!;
                        });
                  }),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              result!.isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          insert({
                            'title': controller.toDoTextController.text,
                            'is_public': controller.checkbox.value
                          });
                        }
                      },
                      child: const Text('create'))
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graph_ql_2/getx_view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../controllers/base_modify_todo_controller.dart';


class ModifyToDoDialog<T extends BaseModifyToDoController> extends GetxView<T> {
  const ModifyToDoDialog(final GetxViewBuilder<T> controller,{Key? key}) : super(controller,key: key);

  @override
  Widget build(BuildContext context) {
        return Mutation(
      options: MutationOptions(
          document: gql(controller.modifyMutation)),
      builder: (MultiSourceResult<dynamic> Function(Map<String, dynamic>,
                  {Object? optimisticResult})
              insert,
          QueryResult<dynamic>? result) {
               if(result?.data !=null){
         controller.setData(result: result!);
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
                          insert(controller.setMapForRunMutation());
                        }
                      },
                      child: Text(controller.textButten))
            ],
          ),
        );
      },
    );
  }

}

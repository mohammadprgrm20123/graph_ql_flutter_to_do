

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget{
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title:  const Text(
       'delete this item?',
        style: TextStyle(fontSize: 13),
      ),
      actions: [
        TextButton(onPressed: (){

        }, child: const Text('delete')),

        TextButton(onPressed: (){

        }, child: const Text('back'))
      ],
    );

  }



}
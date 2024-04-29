// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_app/utlities/mybutton.dart';

class DialogBox extends StatelessWidget {
  void Function() onSave;
  void Function() onCancel;

  final controller;
  DialogBox({
    super.key,
    this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 168, 162, 99),
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "add a new task",
              ),
            ),
            Row(
              children: [
                //save button
                MyButton(text: "save", onpressed: onSave),
                const Spacer(),
                MyButton(
                  text: "cancel",
                  onpressed: onCancel,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({super.key, required this.todo, this.onToDoChanged, this.onDeleteItem});



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChanged(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),

        tileColor: Colors.white,
        leading: Icon(
          todo.isDone?  Icons.check_box: Icons.check_box_outline_blank,
          color: Colors.blue,
        ),

        title: Text(
          todo.todoText!,
          style: TextStyle(decoration:todo.isDone? TextDecoration.lineThrough: null),
        ),
        trailing: Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(20)

          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 20,
            icon: Icon(Icons.delete),
            onPressed: () {
              // print('Xoá thông tin');
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}

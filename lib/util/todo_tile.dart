import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class todoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  todoTile(
      {Key? key,
      required this.taskName,
      required this.taskCompleted,
      required this.onChanged,
      required this.deleteFunction})
      : super(key: key);

  //get deleteFunction => null;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, top: 25),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete_outline,
              backgroundColor: Color(0xFFDA4F79),
              borderRadius: BorderRadius.circular(15),
            )
          ],
        ),
        child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF70A866),
                Color(0xFF647EA2),
                Color(0xFFB08BC7),
              ], begin: Alignment.topLeft, end: Alignment.bottomCenter,

              ),
                //color: Color(0xFF8A78A6),
                borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Checkbox(value: taskCompleted, onChanged: onChanged),
                Text(taskName,
                    style: TextStyle(
                      fontSize: 17,
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
              ],
            )),
      ),
    );
  }
}

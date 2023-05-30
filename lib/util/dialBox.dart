import 'package:flutter/material.dart';

class DialogBox extends StatefulWidget {
  final controller ;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox(
      {Key? key,
      required this.controller,
      required this.onSave,
      required this.onCancel})
      : super(key: key);

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              Color(0xFF70A866),
              Color(0xFF647EA2),
              Color(0xFFB08BC7),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        height: 170,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              style: TextStyle(fontSize: 20),
              controller: widget.controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.task),
                  border: OutlineInputBorder(), hintText: "Add a Task"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: widget.onCancel,
                  icon: Icon(Icons.cancel_outlined),
                  iconSize: 60,
                  color: Colors.black45,
                ),
                IconButton(
                  onPressed: widget.onSave,
                  icon: Icon(Icons.arrow_circle_right_rounded),
                  iconSize: 60,
                  color: Colors.black45,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

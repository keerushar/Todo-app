import 'package:flutter/material.dart';

class TaskCardWidgets extends StatelessWidget {
  final String? title;
  final String? desc;

  TaskCardWidgets({this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32,
        horizontal: 24,
      ),

      margin: EdgeInsets.only(
        bottom: 10
        ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "Unnamed title",
              style: TextStyle(
                color: Color(0xFF211551),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              ),
          Padding(
            padding: EdgeInsets.only(
              top: 10
              ),
          
          child:Text(
            desc ?? "Unnamed Description",
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          )
        ],
      ),
    );
  }
}

class Todowidgets extends StatelessWidget {
  final String? text;
  final bool isChecked;

  Todowidgets({this.text, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 8,
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(
              right: 12.0,
            ),
            decoration: BoxDecoration(
                color: isChecked ? Color(0xFF7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: isChecked ? null : Border.all(
                  width: 1.5,
                  color: Color(0xFF86829D),
                ),
                ),
            child: Image(
              image: AssetImage('assets/images/checked.png'),
            ),
          ),
          Flexible(
            child: Text(
              text ?? 'Unnamed todo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isChecked ? Color(0xFF211551) : Color(0xFF86829D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

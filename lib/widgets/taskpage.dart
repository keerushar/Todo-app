import 'package:flutter/material.dart';
import 'package:todo/main.dart';
import 'package:todo/widgets/widgets.dart';

class TaskPage extends StatefulWidget {
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 24,
                bottom: 6,),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Image(
                          height: 25,
                          width: 25,
                          image: AssetImage('assets/images/arrow.png'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter Task Title',
                            border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: 'Enter description for the task....',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 24,
                      
                    )),
              ),
              Todowidgets(
                text: "Create your first task",
                isChecked: false,
              ),
              Todowidgets(
                text: "this is all what happened",
                isChecked: false,
              ),
              Todowidgets(
                isChecked: true,
              ),
              Todowidgets(
                isChecked: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

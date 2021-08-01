import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/widgets.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  TaskPage({required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _taskTitle = "";  //initialize

  @override
  void initState() {
    
    // used to display task editing section while touch the tasklist
    if (widget.task != null) {
      _taskTitle = widget.task!.title!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24,
                      bottom: 6,
                    ),
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
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (widget.task == null) {
                                  DatabaseHelper _dhelper = DatabaseHelper();
                                  Task _newTask = Task(
                                    title: value,
                                  );
                                  await _dhelper.insertTask(_newTask);
                                } else {
                                  print('Task is updated!!');
                                }
                              }
                            },
                            controller: TextEditingController()..text  = _taskTitle, //jun task ho tei dekhaune while touching this
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
              Positioned(
                bottom: 24,
                right: 24,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskPage(
                                task: null,
                              )),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(
                      image: AssetImage('assets/images/trash.png'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/models/task.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/widgets/widgets.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  TaskPage({required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String _taskTitle = ""; //initialize
  DatabaseHelper _dhelper = DatabaseHelper();
  int _taskId = 0;

  @override
  void initState() {
    // used to display task editing section while touch the tasklist
    if (widget.task != null) {
      _taskTitle = widget.task!.title!;
      _taskId = widget.task!.id!;
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
                            controller: TextEditingController()
                              ..text =
                                  _taskTitle, //jun task ho tei dekhaune while touching this
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
                  FutureBuilder(
                      initialData: [],
                      future: _dhelper.getTodo(_taskId),
                      builder: (context, AsyncSnapshot snapshot) {
                        return Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return Todowidgets(
                                    text: snapshot.data[index].title,
                                    isChecked:
                                        snapshot.data[index].isChecked == 0
                                            ? false
                                            : true,
                                  );
                                }));
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(
                            right: 12.0,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                width: 1.5,
                                color: Colors.black,
                              )),
                          child: Image(
                            image: AssetImage('assets/images/checked.png'),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (_taskId != 0) {
                                  DatabaseHelper _dhelper = DatabaseHelper();
                                  Todo _newTodo = Todo(
                                    title: value,
                                    isChecked: 0,
                                    taskId: _taskId,
                                  );
                                  await _dhelper.insertTodo(_newTodo);
                                  setState(() {});
                                } else {
                                  print('task doesnt exists');
                                }
                              }
                            },
                            decoration: InputDecoration(
                                hintText: "Enter Todo item",
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  )
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

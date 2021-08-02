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
  DatabaseHelper _dhelper = DatabaseHelper();

  String _taskTitle = ""; //initialize
  String _taskDesc = "";
  int _taskId = 0;

  FocusNode? _titleFocus;
  FocusNode? _descFocus;
  FocusNode? _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    // used to display task editing section while touch the tasklist
    if (widget.task != null) {
      _contentVisible = true;
      _taskTitle = widget.task!.title!;
      _taskDesc = widget.task!.desc!;
      _taskId = widget.task!.id!;
    }

    _titleFocus = FocusNode();
    _descFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus!.dispose();
    _descFocus!.dispose();
    _todoFocus!.dispose();
    super.dispose();
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
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              if (value != "") {
                                if (widget.task == null) {
                                  // DatabaseHelper _dhelper = DatabaseHelper();
                                  Task _newTask = Task(
                                    title: value,
                                  );
                                  _taskId = await _dhelper.insertTask(_newTask);
                                  setState(() {
                                    _contentVisible = true;
                                    _taskTitle = value;
                                  });
                                } else {
                                  await _dhelper.updateTaskTitle(
                                      _taskId, value);
                                  print('Task is updated!!');
                                }
                                _descFocus!.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text =
                                  _taskTitle, //jun task ho tei dekhaune while touching this
                            decoration: InputDecoration(
                                hintText: 'Enter Task Title',
                                border: InputBorder.none),

                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: TextField(
                        focusNode: _descFocus,
                        onSubmitted: (value) async {
                          if (value != "") {
                            if (_taskId != 0) {
                              await _dhelper.updateTaskDesc(_taskId, value);
                              _taskDesc = value;
                            }
                          }
                          _todoFocus!.requestFocus();
                        },
                        controller: TextEditingController()..text = _taskDesc,
                        decoration: InputDecoration(
                          hintText: 'Enter description for the task....',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: FutureBuilder(
                        initialData: [],
                        future: _dhelper.getTodo(_taskId),
                        builder: (context, AsyncSnapshot snapshot) {
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        print('kiran is $_taskId');
                                        // print(
                                        // "todo done: ${snapshot.data[index].isChecked}");
                                        if (snapshot.data[index].isChecked ==
                                            0) {
                                          await _dhelper.updateTodoDone(
                                              snapshot.data[index].id, 1);
                                        } else {
                                          await _dhelper.updateTodoDone(
                                              snapshot.data[index].id, 0);
                                        }
                                        setState(() {});
                                      },
                                      child: Todowidgets(
                                        text: snapshot.data[index].title,
                                        isChecked:
                                            snapshot.data[index].isChecked == 0
                                                ? false
                                                : true,
                                      ),
                                    );
                                  }));
                        }),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
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
                                  color: Color(0xFF86829D),
                                )),
                            child: Image(
                              image: AssetImage('assets/images/checked.png'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              focusNode: _todoFocus,
                              controller: TextEditingController()..text = "",
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
                                    _todoFocus!.requestFocus();
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
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Positioned(
                  bottom: 24,
                  right: 24,
                  child: GestureDetector(
                    onTap: () async {
                      if (_taskId != 0) {
                        await _dhelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFFE3577),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image(
                        image: AssetImage('assets/images/trash.png'),
                      ),
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

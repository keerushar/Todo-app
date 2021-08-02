import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/widgets/taskpage.dart';
import 'package:todo/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 32),
                    child: Image(
                      height: 40,
                      width: 40,
                      image: AssetImage('assets/images/to-do-list.png'),
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, AsyncSnapshot snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TaskPage(
                                                  task: snapshot.data[index],
                                                ))).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: TaskCardWidgets(
                                    title: snapshot.data[index].title,
                                    desc: snapshot.data[index].desc,
                                  ),
                                );
                              }),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskPage(
                                task: null,
                              )),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Image(
                      image: AssetImage('assets/images/plus.png'),
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

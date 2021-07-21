import 'package:flutter/material.dart';
import 'package:todo/widgets/taskpage.dart';
import 'package:todo/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                    child: ListView(
                      children: [
                        TaskCardWidgets(
                          title: "Get Started!",
                          desc:
                              "Hello User, Welcome To Todo App where you can add your daily works to make your life more Productive",
                        ),
                        TaskCardWidgets(
                          title: "Get Started!",
                          desc:
                              "Hello User, Welcome To Todo App where you can add your daily works to make your life more Productive",
                        ),
                        TaskCardWidgets(
                          title: "Get Started!",
                          desc:
                              "Hello User, Welcome To Todo App where you can add your daily works to make your life more Productive",
                        ),
                        TaskCardWidgets(
                          title: "Get Started!",
                          desc:
                              "Hello User, Welcome To Todo App where you can add your daily works to make your life more Productive",
                        ),
                      ],
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
                        builder: (context) => TaskPage()
                        ),
                        );
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

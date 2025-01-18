import 'package:flutter/material.dart';
import 'package:lg_task_2/pages/connection_page/Connection.dart';
import 'package:lg_task_2/pages/Controls.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _connectionState = false;
  String _connectionTxt = "NOT CONNECTED";

  @override
  void initState() {
    super.initState();
    if (_connectionState) {
      _connectionTxt = _connectionState ? "CONNECTED" : "NOT CONNECTED";
      ;
    }
  }

  void changeConnection(bool value) {
    setState(() {
      _connectionState = value;
      _connectionTxt = _connectionState ? "CONNECTED" : "NOT CONNECTED";
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blueGrey.shade900,
          appBar: AppBar(
            backgroundColor: Colors.blueGrey.shade900,
            title: Text(
              _connectionTxt,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _connectionState ? const Color.fromARGB(255, 59, 160, 62) : const Color.fromARGB(255, 235, 59, 46),
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Home',
                ),
                Tab(
                  text: 'Connection',
                )
              ],
              labelColor: Colors.white,
              dividerColor: Colors.black26,
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.grey[500],
            ),
          ),
          body: TabBarView(children: [
            Controls(),
            Connection(onConnectionChanged: changeConnection,)
          ]),
        ));
  }
}

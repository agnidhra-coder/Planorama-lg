// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lg_task_2/kmls/college.dart';
import 'package:lg_task_2/kmls/first_point.dart';
import 'package:lg_task_2/services/lg_service.dart';
import 'package:lg_task_2/config/ssh.dart';

class Controls extends StatefulWidget {
  const Controls({super.key});

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  int? selectedIndex;
  bool isLoading = false;
  SSH ssh = SSH();

  List<String> taskNames = [
    'Add LG Logo',
    'Pass KMLs',
    'Remove LG Logo',
    'Remove KMLs'
  ];

  performTask(int index, {int? buttonId}) {
    setState(() {
      isLoading = true;
    });
    switch (index) {
      case 0:
        addLogo();
        print('Adding logo');
        break;
      case 1:
        if (buttonId == 1){
          sendCollegeKml();
          print('Sending 1st kml');

        } else if (buttonId == 2){
          sendFPKml();
          print('Sending 2nd kml');
        }
        
        break;
      case 2:
        removeLogo();
        print('Removing Logo');
        break;
      case 3:
        removeKml();
        print('Removing KML');
        break;
    }
  }
  
  void addLogo() async {
    SSH ssh = SSH();
    LGService lgService = LGService();
    setState(() {
      isLoading = true;
    });

    await ssh.connectToLG();
    try {
      await lgService.setLogos();
      setState(() {
        isLoading = false;
      });
      final snackbar = SnackBar(
        backgroundColor: Colors.white70,
        content: Text(
          "Successfully added!",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
      final snackbar = SnackBar(
        backgroundColor: Colors.red[400],
        content: Text("An error occured"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void removeKml() async {
    SSH ssh = SSH();
    LGService lgService = LGService();
    setState(() {
      isLoading = true;
    });
    await ssh.connectToLG();
    try {
      await lgService.clearKml();
      setState(() {
        isLoading = false;
      });
      final snackbar = SnackBar(
        backgroundColor: Colors.white70,
        content: Text(
          "Successfully removed!",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
      final snackbar = SnackBar(
        backgroundColor: Colors.red[400],
        content: Text("An error occured"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void removeLogo() async {
    SSH ssh = SSH();
    LGService lgService = LGService();
    setState(() {
      isLoading = true;
    });
    await ssh.connectToLG();
    try {
      await lgService.cleanKML(3);
      setState(() {
        isLoading = false;
      });
      final snackbar = SnackBar(
        backgroundColor: Colors.white70,
        content: Text(
          "Successfully removed!",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
      final snackbar = SnackBar(
        backgroundColor: Colors.red[400],
        content: Text("An error occured"),
        duration: Duration(seconds: 2)
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      
    }
  }

  void sendCollegeKml() async {
    SSH ssh = SSH();
    LGService lgService = LGService();
    String clgKml = CollegeKML().getCollegeKml();
    setState(() {
      isLoading = true;
    });

    await ssh.connectToLG();
    try {
      await lgService.sendKml('collegeKml', clgKml, 86.441249, 23.8144169, 1029);
      setState(() {
        isLoading = false;
      });
      final snackbar = SnackBar(
        backgroundColor: Colors.white70,
        content: Text(
          "Successfully passed!",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      print(e.toString());
      final snackbar = SnackBar(
        backgroundColor: Colors.red[400],
        content: Text("An error occured"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      setState(() {
        isLoading = false;
      });
    }
  }

  void sendFPKml() async {
    SSH ssh = SSH();
    LGService lgService = LGService();
    String fpKml = FirstPoint().getFirstPointKml();
    setState(() {
      isLoading = true;
    });

    await ssh.connectToLG();
    try {
      await lgService.sendKml('fpKml', fpKml, 88.3517949334374, 22.55280162028466, 1029);
      setState(() {
        isLoading = false;
      });
      final snackbar = SnackBar(
        backgroundColor: Colors.white70,
        content: Text(
          "Successfully passed!",
          style: TextStyle(
            color: Colors.black
          ),
        ),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e.toString());
      final snackbar = SnackBar(
        backgroundColor: Colors.red[400],
        content: Text("An error occured"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  int? expandedCardIndex;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.blueGrey.shade900,
        child: Stack(
          children: [
            GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cards per row
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: 4, // Number of cards
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      expandedCardIndex = expandedCardIndex == index ? null : index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[700],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        taskNames[index],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        
            if (expandedCardIndex != null)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      expandedCardIndex = null;
                    });
                  },
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(color: Colors.white.withOpacity(0.001)),
                  ),
                ),
              ),
        
            if (expandedCardIndex != null)
              Positioned(
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
                top: screenHeight * 0.2,
                height: screenHeight * 0.4,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[700],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          taskNames[expandedCardIndex!],
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        ),
                        SizedBox(height: 20),
                        if (expandedCardIndex == 1)
                          Column(
                            children: [
                              TextButton(
                                onPressed: () => performTask(expandedCardIndex!, buttonId: 1),
                                child: Text("Pass KML 1"),
                              ),
                              SizedBox(height: 10),
                              TextButton(
                                onPressed: () => performTask(expandedCardIndex!, buttonId: 2),
                                child: Text("Pass KML 2"),
                              ),
                            ],
                          )
                        else
                          TextButton(
                            onPressed: () => performTask(expandedCardIndex!),
                            child: Text(
                              "Execute",
                            ),
                          ),
                        SizedBox(height: 20,),
                        if(isLoading) ...[
                          SizedBox(width: 20,),
                          SpinKitThreeBounce(
                            color: Colors.white70,
                            size: 15,
                          )
                        ]
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
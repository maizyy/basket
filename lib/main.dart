import 'dart:math';

import 'package:flutter/material.dart';
import 'player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
      },
    );
  }
}

class TeamsScore {
  dynamic teams;
  TeamsScore(this.teams);
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, List<Map<String, dynamic>>> score = {
    'team1': [
      {
        'playerName': '',
        'points': 0,
        '3pm': 0,
        '2pm': 0,
        '3pa': 0,
        '2pa': 0,
        'fgm': 0,
        'fga': 0,
      },
    ],
    'team2': [
      {
        'playerName': '',
        'points': 0,
        '3pm': 0,
        '2pm': 0,
        '3pa': 0,
        '2pa': 0,
        'fgm': 0,
        'fga': 0,
      },
    ],
  };
  bool addFlag = false;
  @override
  Widget build(BuildContext context) {
    void addPoints(var val, int point) {
      setState(() {
        val['points'] += point;
      });
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...score.values.map((el) {
                    int points = 0;
                    for (var score in el) {
                      setState(() {
                        points += score['points'];
                      });
                    }

                    return Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text(
                            '$points',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...el.map((val) {
                            return Player(
                              name: val['playerName'],
                              playerScore: val['points'],
                              threePM: val['3pm'],
                              twoPM: val['2pm'],
                              threePA: val['3pa'],
                              twoPA: val['2pa'],
                              minusTwoPointer: () {
                                addPoints(val, -2);
                                val['2pm']--;
                                val['2pa']--;
                              },
                              twoPointer: () {
                                addPoints(val, 2);
                                val['2pm']++;
                                val['2pa']++;
                              },
                              twoPointerAttempt: () {
                                setState(() {
                                  val['2pa']++;
                                });
                              },
                              minusTwoPointerAttempt: () {
                                setState(() {
                                  val['2pa']--;
                                });
                              },
                              minusThreePointer: () {
                                addPoints(val, -3);
                                val['3pm']--;
                                val['3pa']--;
                              },
                              threePointer: () {
                                addPoints(val, 3);
                                val['3pm']++;
                                val['3pa']++;
                              },
                              threePointerAttempt: () {
                                setState(() {
                                  val['3pa']++;
                                });
                              },
                              minusThreePointerAttempt: () {
                                setState(() {
                                  val['3pa']--;
                                });
                              },
                              submit: (res) {
                                setState(() {
                                  val['playerName'] = res;
                                });
                              },
                            );
                          }),
                          addFlag
                              ? OutlineButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      el.add({
                                        'playerName': '',
                                        'points': 0,
                                        '3pm': 0,
                                        '2pm': 0,
                                        '3pa': 0,
                                        '2pa': 0,
                                        'fgm': 0,
                                        'fga': 0,
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.add),
                                  label: Text('Dodaj'),
                                )
                              : SizedBox(
                                  width: 1,
                                ),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onLongPress: () {
          print('object');
        },
        child: FloatingActionButton(
            backgroundColor: !addFlag ? Colors.blueAccent : Colors.redAccent,
            onPressed: () {
              setState(() {
                addFlag = !addFlag;
              });
            },
            child: !addFlag
                ? Icon(
                    Icons.add,
                    size: 35,
                    color: Colors.white,
                  )
                : Transform.rotate(
                    angle: pi / 4,
                    child: Icon(
                      Icons.add,
                      size: 35,
                      color: Colors.white,
                    ),
                  )),
      ),
    );
  }
}

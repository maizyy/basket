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
        'assist': 0,
        'rebounds': 0,
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
        'assist': 0,
        'rebounds': 0,
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
    void addToPlayerStats(var val, String stat, int point) {
      setState(() {
        val[stat] += point;
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
                              assists: val['assist'],
                              rebounds: val['rebounds'],
                              threePM: val['3pm'],
                              twoPM: val['2pm'],
                              threePA: val['3pa'],
                              twoPA: val['2pa'],
                              minusTwoPointer: () {
                                addToPlayerStats(val, 'points', -2);
                                addToPlayerStats(val, '2pm', -1);
                                addToPlayerStats(val, '2pa', -1);
                              },
                              twoPointer: () {
                                addToPlayerStats(val, 'points', 2);
                                addToPlayerStats(val, '2pm', 1);
                                addToPlayerStats(val, '2pa', 1);
                              },
                              twoPointerAttempt: () {
                                addToPlayerStats(val, '2pa', 1);
                              },
                              minusTwoPointerAttempt: () {
                                addToPlayerStats(val, '2pa', -1);
                              },
                              minusThreePointer: () {
                                addToPlayerStats(val, 'points', -3);
                                addToPlayerStats(val, '3pm', -1);
                                addToPlayerStats(val, '3pa', -1);
                              },
                              threePointer: () {
                                addToPlayerStats(val, 'points', 3);
                                addToPlayerStats(val, '3pm', 1);
                                addToPlayerStats(val, '3pa', 1);
                              },
                              threePointerAttempt: () {
                                addToPlayerStats(val, '3pa', 1);
                              },
                              minusThreePointerAttempt: () {
                                addToPlayerStats(val, '3pa', -1);
                              },
                              addAssist: () {
                                addToPlayerStats(val, 'assist', 1);
                              },
                              addRebound: () {
                                addToPlayerStats(val, 'rebounds', 1);
                              },
                              removeAssist: () {
                                addToPlayerStats(val, 'assist', -1);
                              },
                              removeRebound: () {
                                addToPlayerStats(val, 'rebounds', -1);
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
                                        'assist': 0,
                                        'rebounds': 0,
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

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
  var teams;
  TeamsScore(this.teams);
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Map<String, List<Object>> teams = {
  //   'team1': [
  //     {
  //       'playerName': 'Izba',
  //       'points': 0,
  //     },
  //   ],
  //   'team2': [
  //     {
  //       'playerName': 'Sawik',
  //       'points': 0,
  //     }
  //   ],
  // };
  TeamsScore score = TeamsScore({
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
  });
  Map<String, int> teamsPoints = {
    'team1': 0,
    'team2': 0,
  };

  void calculateScore() {
    teamsPoints['team1'] = 0;
    teamsPoints['team2'] = 0;
    for (var score in score.teams['team1']) {
      teamsPoints['team1'] += score['points'];
    }
    for (var score in score.teams['team2']) {
      teamsPoints['team2'] += score['points'];
    }
  }

  @override
  Widget build(BuildContext context) {
    void addPoints(var val, int point) {
      setState(() {
        val['points'] += point;
        calculateScore();
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
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              teamsPoints['team1'].toString(),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...score.teams['team1'].map((val) {
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
                            })
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              teamsPoints['team2'].toString(),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...score.teams['team2'].map((val) {
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
                            })
                          ],
                        ),
                      ),
                    ],
                  )
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
          onPressed: () {
            setState(() {
              score.teams['team1'].add({
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
            setState(() {
              score.teams['team2'].add({
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
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
    );
  }
}

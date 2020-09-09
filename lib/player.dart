import 'package:flutter/material.dart';

class Player extends StatefulWidget {
  final String name;
  final int playerScore;
  final int threePM;
  final int twoPM;
  final int threePA;
  final int twoPA;
  final Function twoPointer;
  final Function minusTwoPointer;
  final Function twoPointerAttempt;
  final Function minusTwoPointerAttempt;
  final Function threePointer;
  final Function minusThreePointer;
  final Function threePointerAttempt;
  final Function minusThreePointerAttempt;
  final Function submit;

  Player({
    Key key,
    this.name,
    this.playerScore,
    this.threePM,
    this.twoPM,
    this.twoPointer,
    this.minusTwoPointer,
    this.minusThreePointer,
    this.threePointer,
    this.submit,
    this.threePA,
    this.twoPA,
    this.twoPointerAttempt,
    this.threePointerAttempt,
    this.minusTwoPointerAttempt,
    this.minusThreePointerAttempt,
  }) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    int calculateFGM() {
      return widget.threePM + widget.twoPM;
    }

    int calculateFGA() {
      return widget.threePA + widget.twoPA;
    }

    return Column(
      children: <Widget>[
        Container(
          height: 100,
          margin: EdgeInsets.all(1),
          child: widget.name.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: TextField(
                    onSubmitted: widget.submit,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Zawodnik',
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              widget.name,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                widget.playerScore.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Text(
                              '${calculateFGM()}/${calculateFGA()}',
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            '2PM: ${widget.twoPM}/${widget.twoPA}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            '3PM: ${widget.threePM}/${widget.threePA}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: const EdgeInsets.all(0.0),
                              child: Container(
                                child: Text('2'),
                              ),
                              onPressed: widget.twoPointer,
                              onLongPress: widget.minusTwoPointer,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: FlatButton(
                                child: Text('2'),
                                onPressed: widget.twoPointerAttempt,
                                onLongPress: widget.minusTwoPointerAttempt,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: RaisedButton(
                                child: Text('3'),
                                onPressed: widget.threePointer,
                                onLongPress: widget.minusThreePointer,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: FlatButton(
                                child: Text('3'),
                                onPressed: widget.threePointerAttempt,
                                onLongPress: widget.minusThreePointerAttempt,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        )
      ],
    );
  }
}

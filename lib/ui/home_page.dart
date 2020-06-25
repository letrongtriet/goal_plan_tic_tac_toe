import 'package:flutter/material.dart';
import 'package:goal_plan_tic_tac_toe/ui/home_presenter.dart';
import 'package:goal_plan_tic_tac_toe/ui/game_page.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePresenter _presenter;
  _HomePageState() {
    _presenter = HomePresenter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: ButtonTheme(
              minWidth: 200,
              height: 80,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GamePage("Let's Play"))
                  );
                },
                child: Text("New game", style: TextStyle(fontSize: 20),),
              ),
            ),
          ),

          Container (
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: Future.wait([
                _presenter.getGamePlayFromStorage(),
                _presenter.getVictoryCountFromStorage(),
                _presenter.getLoseCountFromStorage()
            ]), builder: (context, AsyncSnapshot<List<Preference<int>>> snapshot) {
              if (!snapshot.hasData) { 
                  return CircularProgressIndicator();
              }

              return Column(
                children: <Widget>[
                  PreferenceBuilder<int>(
                    preference: snapshot.data[0],
                    builder: (context, value) => Text('Played: $value'),
                  ),

                  PreferenceBuilder<int>(
                    preference: snapshot.data[1],
                    builder: (context, value) => Text('Won: $value'),
                  ),

                  PreferenceBuilder<int>(
                    preference: snapshot.data[2],
                    builder: (context, value) => Text('Lost: $value'),
                  ),

                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    color: Colors.blueAccent,
                    onPressed: () {
                      _presenter.resetAllStats();
                    },
                    child: Text("Reset statistic", style: TextStyle(fontSize: 15),),
                  ),
                ]
              );
            })
          ),
        ],
      ),
    );
  }

}

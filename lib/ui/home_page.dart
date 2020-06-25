import 'package:flutter/material.dart';
import 'package:goal_plan_tic_tac_toe/storage/game_info_repository.dart';
import 'package:goal_plan_tic_tac_toe/ui/game_page.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<GameInfoRepository> getRepository() async {
    return await GameInfoRepository.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Container (
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<GameInfoRepository>(
              future: getRepository(),
              builder: (BuildContext context, AsyncSnapshot<GameInfoRepository> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      ButtonTheme(
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
                                MaterialPageRoute(builder: (context) => GamePage("Let's Play", snapshot.data))
                            );
                          },
                          child: Text("New game", style: TextStyle(fontSize: 20),),
                        ),
                      ),

                      Spacer(),

                      PreferenceBuilder<int>(
                        preference: snapshot.data.getGamePlay(),
                        builder: (context, value) => Text('Played: $value'),
                      ),

                      PreferenceBuilder<int>(
                        preference: snapshot.data.getVictoryCount(),
                        builder: (context, value) => Text('Won: $value'),
                      ),

                      PreferenceBuilder<int>(
                        preference: snapshot.data.getLoseCount(),
                        builder: (context, value) => Text('Lost: $value'),
                      ),

                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blueAccent, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        color: Colors.blueAccent,
                        onPressed: () {
                          snapshot.data.resetAll();
                        },
                        child: Text("Reset statistic", style: TextStyle(fontSize: 15),),
                      ),
                    ]
                  );
                } else {
                  return new CircularProgressIndicator();
                }
              }
            )
          ),
      );
  }

}

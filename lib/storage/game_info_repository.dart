import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class GameInfoRepository {
  static const String WIN_COUNT = "win";
  static const String LOSE_COUNT = "lose";
  static const String PLAY_COUNT = "play";

  int win = 0;
  int lose = 0;
  int play = 0;

  static GameInfoRepository _victoryRepository;
  StreamingSharedPreferences preferences;

  static GameInfoRepository getInstance() {
    if (_victoryRepository == null) {
      _victoryRepository = GameInfoRepository();
    }
    return _victoryRepository;
  }

  Future<Null> createPreference() async {
    preferences = await StreamingSharedPreferences.instance;
  }

  Future<Preference<int>> getVictoryCount() async {
    return preferences.getInt(WIN_COUNT, defaultValue: 0);
  }

  Future<Preference<int>> getLoseCount() async {
    return preferences.getInt(LOSE_COUNT, defaultValue: 0);
  }

  Future<Preference<int>> getGamePlay() async {
    return preferences.getInt(PLAY_COUNT, defaultValue: 0);
  }

  void addVictory() async {
    win += 1;
    preferences.setInt(WIN_COUNT, win);
  }

  void addLose() async {
    lose += 1;
    preferences.setInt(LOSE_COUNT, lose);
  }

  void addGamePlay() async {
    play += 1;
    preferences.setInt(PLAY_COUNT, play);
  }

  void resetAll() async {
    win = 0;
    lose = 0;
    play = 0;

    preferences.setInt(WIN_COUNT, win);
    preferences.setInt(LOSE_COUNT, lose);
    preferences.setInt(PLAY_COUNT, play);
  }

}
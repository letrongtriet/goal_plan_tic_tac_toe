import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class GameInfoRepository {
  static const String WIN_COUNT = "win";
  static const String LOSE_COUNT = "lose";
  static const String PLAY_COUNT = "play";

  int win = 0;
  int lose = 0;
  int play = 0;

  static GameInfoRepository repository;
  static StreamingSharedPreferences preferences;

  static Future<GameInfoRepository> getInstance() async {
    if (repository == null) {
      repository = GameInfoRepository();
    }

    if (preferences == null) {
      preferences = await StreamingSharedPreferences.instance;
    }

    return repository;
  }

  Preference<int> getVictoryCount() {
    return preferences.getInt(WIN_COUNT, defaultValue: 0);
  }

  Preference<int> getLoseCount() {
    return preferences.getInt(LOSE_COUNT, defaultValue: 0);
  }

  Preference<int> getGamePlay() {
    return preferences.getInt(PLAY_COUNT, defaultValue: 0);
  }

  void addVictory() {
    win += 1;
    preferences.setInt(WIN_COUNT, win);
  }

  void addLose() {
    lose += 1;
    preferences.setInt(LOSE_COUNT, lose);
  }

  void addGamePlay() {
    play += 1;
    preferences.setInt(PLAY_COUNT, play);
  }

  void resetAll() {
    win = 0;
    lose = 0;
    play = 0;

    preferences.setInt(WIN_COUNT, win);
    preferences.setInt(LOSE_COUNT, lose);
    preferences.setInt(PLAY_COUNT, play);
  }

}
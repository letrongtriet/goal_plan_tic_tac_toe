import 'package:goal_plan_tic_tac_toe/storage/game_info_repository.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class HomePresenter {
  GameInfoRepository repository;

  HomePresenter() {
    repository = GameInfoRepository.getInstance();
  }

  Future<Preference<int>> getVictoryCountFromStorage() async {
    return repository.getVictoryCount();
  }

  Future<Preference<int>> getLoseCountFromStorage() async {
    return repository.getLoseCount();
  }

  Future<Preference<int>> getGamePlayFromStorage() async {
    return repository.getGamePlay();
  }

  void resetAllStats() {
    repository.resetAll();
  }

}
import 'package:ps5_games_browser_app/models/game_list_model.dart';

abstract class GamesState {}

class GamesListInitial extends GamesState {}

class GamesListLoading extends GamesState {}

class GamesListLoaded extends GamesState {
  final List<GameModel> games;

  GamesListLoaded(this.games);
}

class GamesListErrorState extends GamesState {
  final String errorMessage;

  GamesListErrorState(this.errorMessage);
}

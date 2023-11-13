import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_bloc.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_events.dart';
import 'package:ps5_games_browser_app/blocs/games/games_list_states.dart';

class GameListScreen extends StatefulWidget {
  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  @override
  Widget build(BuildContextcontext) {
    final gamesListBloc = BlocProvider.of<GamesListBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('PlayStation 5 Games'),
      ),
      body: BlocBuilder<GamesListBloc, GamesState>(
        builder: (context, state) {
          if (state is GamesListInitial) {
            // Trigger the event only once when the widget is initially built
            gamesListBloc.add(LoadGameListEvent());
          }
          if (state is GamesListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GamesListLoaded) {
            return ListView.builder(
              itemCount: state.games.length,
              itemBuilder: (context, index) {
                final game = state.games[index];
                return ListTile(
                    title: Text(game.name),
                    subtitle: Text(game.releaseDate),
                    leading: Image.network(game.backgroundImage),
                    trailing: Text('Metacritic Score: ${game.metacriticScore}'),
                    // Add onTap functionality to navigate to Game Details View
                    onTap: () {});
              },
            );
          } else if (state is GamesListErrorState) {
            return Center(
              child: Text('Error: ${state.errorMessage}'),
            );
          } else {
            // Default case in case of unexpected state
            return Center(
              child: Text('Unexpected state: $state'),
            );
          }
        },
      ),
    );
  }
}
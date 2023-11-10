import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_uplabs/domain/entities/movie.dart';
import 'package:movie_app_uplabs/infrastructure/datasources/moviedb_datasource.dart';
import 'package:movie_app_uplabs/infrastructure/repositories/movie_repository_impl.dart';
import 'package:movie_app_uplabs/presentation/blocs/movies_bloc/movies_bloc.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieRepositoryImpl = MovieRepositoryImpl(MoviedbDatasource());

    return Scaffold(
      body: BlocProvider(
        create: (_) {
          final movieBloc = MovieBloc(movieRepository: movieRepositoryImpl);
          movieBloc.add(FetchMoviesEvent());
          return movieBloc;
        },
        child: const _HomeView(),
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state is MovieLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is MovieLoadedState) {
                print(state.movies[1]);
                return _ListMovies(state.movies);
              } else if (state is MovieErrorState) {
                return Text('Error: ${state.error}');
              } else {
                return Container(); // Puedes manejar otros estados según tus necesidades
              }
            },
          );
  }
}

class _ListMovies extends StatelessWidget {
  final List<Movie> movies;
  const _ListMovies(this.movies);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return ListTile(
          title: Text(movie.title),
        );
      },
    );
  }
}

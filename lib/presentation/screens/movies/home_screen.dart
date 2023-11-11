import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_uplabs/domain/entities/movie.dart';
import 'package:movie_app_uplabs/infrastructure/datasources/moviedb_datasource.dart';
import 'package:movie_app_uplabs/infrastructure/repositories/movie_repository_impl.dart';
import 'package:movie_app_uplabs/presentation/blocs/movies_bloc/movies_bloc.dart';
import 'package:movie_app_uplabs/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieRepositoryImpl = MovieRepositoryImpl(MoviedbDatasource());

    return BlocProvider(
      create: (_) {
        final movieBloc = MovieBloc(movieRepository: movieRepositoryImpl);
        movieBloc.add(FetchMoviesEvent());
        return movieBloc;
      },
      child: const Scaffold(
        body: _HomeView(),
        bottomNavigationBar: CustomBottomNavbar(),
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
        if (state is MovieLoadedState) {
          return _ListMovies(state.movies);
        } else if (state is MovieErrorState) {
          return Text('Error: ${state.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
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
    return Column(
      children: [
        const CustomAppbar(),
        Expanded(
          child: MovieGridListview(
            movies: movies,
            loadNextPage: () =>
                context.read<MovieBloc>().add(FetchMoreMoviesEvent()),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_app_uplabs/domain/entities/movie.dart';
import 'package:movie_app_uplabs/infrastructure/datasources/moviedb_datasource.dart';
import 'package:movie_app_uplabs/infrastructure/repositories/movie_repository_impl.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  late MoviedbDatasource moviesDatasource;
  late MovieRepositoryImpl movieRepositoryImpl;
  late Future<List<Movie>> _data;

  @override
  void initState() {
    super.initState();
    moviesDatasource = MoviedbDatasource();
    movieRepositoryImpl = MovieRepositoryImpl(moviesDatasource);
    _data = movieRepositoryImpl.getNowPlaying();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      // initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _ListMovies(snapshot.data);
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

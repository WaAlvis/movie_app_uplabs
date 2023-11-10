part of 'movies_bloc.dart';

// Estados
abstract class MovieState {}

class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<Movie> movies;

  MovieLoadedState({required this.movies});
}

class MovieErrorState extends MovieState {
  final String error;

  MovieErrorState({required this.error});
}

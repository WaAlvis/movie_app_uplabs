part of 'movies_bloc.dart';

// Estados
abstract class MovieState {}

// class MovieInitialState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieLoadedState extends MovieState {
  final List<Movie> movies;
  final bool hasReachedMax;

  MovieLoadedState({required this.movies, required this.hasReachedMax});

  // Método copyWith para crear una nueva instancia con algunos campos modificados
  MovieLoadedState copyWith({List<Movie>? movies, bool? hasReachedMax}) {
    return MovieLoadedState(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class MovieErrorState extends MovieState {
  final String error;

  MovieErrorState({required this.error});
}

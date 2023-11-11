part of 'movie_detail_cubit.dart';

abstract class MovieDetailState {}

class MovieDetailInitialState extends MovieDetailState {}

class MovieDetailLoadingState extends MovieDetailState {}

class MovieDetailLoadedState extends MovieDetailState {
  final Movie movieDetail;

  MovieDetailLoadedState({required this.movieDetail});
}

class MovieDetailErrorState extends MovieDetailState {
  final String error;

  MovieDetailErrorState({required this.error});
}
part of 'movies_bloc.dart';

// Eventos
abstract class MovieEvent {}

class FetchMoviesEvent extends MovieEvent {}
class FetchMoreMoviesEvent extends MovieEvent {}
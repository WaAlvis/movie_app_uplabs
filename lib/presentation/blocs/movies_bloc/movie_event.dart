/// Este archivo forma parte del archivo 'movie_bloc.dart' y contiene definiciones 
/// relacionadas con los eventos utilizados en el BLoC de películas.

part of 'movie_bloc.dart';

/// Representa los eventos que pueden ser procesados por el BLoC de películas.
///
/// **Lista de Eventos**
/// 1. [FetchMoviesEvent]
/// 2. [FetchMoreMoviesEvent]

abstract class MovieEvent {}

/// Evento para solicitar la carga inicial de películas.
class FetchMoviesEvent extends MovieEvent {}

/// Evento para solicitar la carga de más películas, generalmente utilizado para la paginación.
class FetchMoreMoviesEvent extends MovieEvent {}
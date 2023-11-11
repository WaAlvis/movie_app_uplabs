/// Este archivo forma parte del archivo 'movie_bloc.dart' y contiene definiciones 
/// relacionadas con los estados utilizados en el BLoC de películas.
part of 'movie_bloc.dart';


/// Representa los diferentes **[MovieState]**  en los que puede estar la aplicación
/// en relación con la obtención de películas.
///
/// **Lista de states**
/// * [MovieInitialState]
/// * [MovieLoadingState]
/// * [MovieLoadedState]
/// * [MovieErrorState]
abstract class MovieState {}


/// Estado inicial de la aplicación antes de cargar las películas.
class MovieInitialState extends MovieState {}

/// Estado que indica que se están cargando las películas.
class MovieLoadingState extends MovieState {}

/// Estado que indica que las películas se han cargado correctamente.
class MovieLoadedState extends MovieState {
  /// Lista de películas cargadas.
  final List<Movie> movies;

  /// Indica si se ha alcanzado el final de la lista de películas.
  final bool hasReachedMax;

  /// Constructor para el estado cargado de películas.
  MovieLoadedState({required this.movies, required this.hasReachedMax});

  /// Método copyWith para crear una nueva instancia con algunos campos modificados.
  MovieLoadedState copyWith({List<Movie>? movies, bool? hasReachedMax}) {
    return MovieLoadedState(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

/// Estado que indica que ha ocurrido un error al intentar cargar las películas.
class MovieErrorState extends MovieState {
  /// Mensaje de error descriptivo.
  final String error;

  /// Constructor para el estado de error.
  MovieErrorState({required this.error});
}

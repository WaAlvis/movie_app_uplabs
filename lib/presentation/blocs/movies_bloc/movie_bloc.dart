import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_uplabs/domain/entities/movie.dart';
import 'package:movie_app_uplabs/infrastructure/repositories/movie_repository_impl.dart';

// Importa las definiciones de eventos y estados asociadas con este BLoC.
part 'movie_event.dart';
part 'movie_state.dart';

/// BLoC (Business Logic Component) para gestionar el estado relacionado
/// con la obtención y paginación de películas.
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepositoryImpl movieRepository;

  /// Lista que almacena todas las películas cargadas hasta el momento.
  List<Movie> allMovies = [];

  /// Número de la página actual para la paginación.
  int page = 1;

  /// Constructor que inicializa el BLoC con un estado inicial y que maejara los **[MovieState]** de mis Peliculas.
  MovieBloc({required this.movieRepository})
      : super(MovieLoadedState(movies: [], hasReachedMax: false));

  /// Mapea los eventos a los estados correspondientes.
  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMoviesEvent) {
      yield* _mapFetchMoviesToState();
    } else if (event is FetchMoreMoviesEvent) {
      yield* _mapFetchMoreMoviesToState();
    }
  }

  /// Maneja el evento de carga inicial de películas.
  Stream<MovieState> _mapFetchMoviesToState() async* {
    try {
      // Obtiene la lista de películas que se están reproduciendo actualmente.
      final List<Movie> movies = await movieRepository.getNowPlaying(page: 1);

      // Actualiza la lista de películas en el BLoC y emite un nuevo estado.
      allMovies = movies;
      yield MovieLoadedState(movies: allMovies, hasReachedMax: false);
    } catch (error) {
      // Emite un estado de error en caso de que falle la obtención de películas.
      yield MovieErrorState(error: 'Failed to fetch movies');
    }
  }

  /// Maneja el evento de carga de más películas (paginación).
  Stream<MovieState> _mapFetchMoreMoviesToState() async* {
    try {
      // Obtiene la lista de películas de la siguiente página.
      final List<Movie> newMovies = await movieRepository.getNowPlaying(page: page + 1);

      if (newMovies.isEmpty) {
        // Si no hay más películas, emite un estado indicando que se ha alcanzado el final.
        yield (state as MovieLoadedState).copyWith(hasReachedMax: true);
      } else {
        // Agrega las nuevas películas a la lista existente y emite un nuevo estado.
        allMovies.addAll(newMovies);
        yield MovieLoadedState(movies: allMovies, hasReachedMax: false);
        page++;
      }
    } catch (error) {
      // Emite un estado de error en caso de que falle la obtención de más películas.
      yield MovieErrorState(error: 'Failed to fetch more movies');
    }
  }
}

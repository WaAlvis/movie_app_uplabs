import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_uplabs/domain/entities/movie.dart';
import 'package:movie_app_uplabs/infrastructure/repositories/movie_repository_impl.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepositoryImpl movieRepository;

  List<Movie> allMovies = [];
  int page = 1;

  MovieBloc({required this.movieRepository}) : super(MovieLoadedState(movies: [], hasReachedMax: false));

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMoviesEvent) {
      yield* _mapFetchMoviesToState();
    } else if (event is FetchMoreMoviesEvent) {
      yield* _mapFetchMoreMoviesToState();
    }
  }

  Stream<MovieState> _mapFetchMoviesToState() async* {
    try {
      final List<Movie> movies = await movieRepository.getNowPlaying(page: 1);
      allMovies = movies;
      yield MovieLoadedState(movies: allMovies, hasReachedMax: false);
    } catch (error) {
      yield MovieErrorState(error: 'Failed to fetch movies');
    }
  }

  Stream<MovieState> _mapFetchMoreMoviesToState() async* {
    try {
      final List<Movie> newMovies = await movieRepository.getNowPlaying(page: page + 1);

      if (newMovies.isEmpty) {
        yield (state as MovieLoadedState).copyWith(hasReachedMax: true);
      } else {
        allMovies.addAll(newMovies);
        yield MovieLoadedState(movies: allMovies, hasReachedMax: false);
        page++;
      }
    } catch (error) {
      yield MovieErrorState(error: 'Failed to fetch more movies');
    }
  }

  // @override
  // Stream<MovieState> mapEventToState(MovieEvent event) async* {
  //   if (event is FetchMoviesEvent) {
  //     yield MovieLoadingState();

  //     try {
  //       final List<Movie> movies = await movieRepository.getNowPlaying();
  //       allMovies = movies;
  //       yield MovieLoadedState(movies: allMovies);
  //     } catch (error) {
  //       yield MovieErrorState(error: 'Failed to fetch movies');
  //     }
  //   } else if (event is FetchMoreMoviesEvent) {
  //     // Handle paginated fetch event
  //     yield MovieLoadingState();

  //     try {
        
  //       final List<Movie> moreMovies =
  //           await movieRepository.getNowPlaying(page: page++);
  //       allMovies.addAll(moreMovies);
  //       yield MovieLoadedState(movies: allMovies);
  //     } catch (error) {
  //       yield MovieErrorState(error: 'Failed to fetch more movies');
  //     }
  //   }
  // }
}

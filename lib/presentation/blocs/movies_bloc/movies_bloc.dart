import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_uplabs/domain/entities/movie.dart';
import 'package:movie_app_uplabs/infrastructure/repositories/movie_repository_impl.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepositoryImpl movieRepository;

  MovieBloc({required this.movieRepository}) : super(MovieInitialState());

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is FetchMoviesEvent) {
      yield MovieLoadingState();

      try {
        final List<Movie> movies = await movieRepository.getNowPlaying();
        yield MovieLoadedState(movies: movies);
      } catch (error) {
        yield MovieErrorState(error: 'Failed to fetch movies');
      }
    }
  }
}

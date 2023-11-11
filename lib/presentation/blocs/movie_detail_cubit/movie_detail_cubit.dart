import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_uplabs/domain/entities/movie.dart';
import 'package:movie_app_uplabs/infrastructure/repositories/movie_repository_impl.dart';

part 'movie_detail_state.dart';

// movie_detail_cubit.dart

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final MovieRepositoryImpl movieRepository;

  MovieDetailCubit({required this.movieRepository})
      : super(MovieDetailInitialState());

  Future<void> fetchMovieDetail(String movieId) async {
    emit(MovieDetailLoadingState());

    try {
      final Movie movieDetail = await movieRepository.getMovieById(movieId);
      emit(MovieDetailLoadedState(movieDetail: movieDetail));
    } catch (error) {
      emit(MovieDetailErrorState(error: 'Failed to fetch movie detail'));
    }
  }
}

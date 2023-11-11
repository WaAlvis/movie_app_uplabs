import 'package:movie_app_uplabs/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<Movie> getMovieById( String id );
}

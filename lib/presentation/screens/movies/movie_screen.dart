import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_uplabs/domain/entities/movie.dart';
import 'package:movie_app_uplabs/infrastructure/datasources/moviedb_datasource.dart';
import 'package:movie_app_uplabs/infrastructure/repositories/movie_repository_impl.dart';
import 'package:movie_app_uplabs/presentation/blocs/movie_detail_cubit/movie_detail_cubit.dart';

class MovieScreen extends StatelessWidget {
  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final movieRepositoryImpl = MovieRepositoryImpl(MoviedbDatasource());
    return Scaffold(
      body: BlocProvider(
        create: (_) => MovieDetailCubit(movieRepository: movieRepositoryImpl)
          ..fetchMovieDetail(movieId),
        child: Builder(
          builder: (context) {
            return BlocBuilder<MovieDetailCubit, MovieDetailState>(
              builder: (context, state) {
                if (state is MovieDetailLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MovieDetailLoadedState) {
                  // Obtén la película del estado
                  final movie = state.movieDetail;
                  return CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      _CustomSliverAppBar(movie: state.movieDetail),
                      SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => _MovieDetails(movie: movie),
                              childCount: 1))
                    ],
                  );
                } else if (state is MovieDetailErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return Container(); // Puedes manejar otros estados según sea necesario.
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title, style: textStyles.displayMedium),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  children: [
                    ...movie.genreIds.map((gender) => Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Chip(
                            label: Text(gender),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ))
                  ],
                ),
              ),
              Text(movie.overview, style: textStyles.headlineSmall),
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomSliverAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        // title: Text(
        //   movie.title,
        //   style: const TextStyle(fontSize: 20),
        //   textAlign: TextAlign.start,
        // ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1.0],
                          colors: [Colors.transparent, Colors.black87]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.topLeft, stops: [
                0.0,
                0.3
              ], colors: [
                Colors.black87,
                Colors.transparent,
              ]))),
            ),
          ],
        ),
      ),
    );
  }
}

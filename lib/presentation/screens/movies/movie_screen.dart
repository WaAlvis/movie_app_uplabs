import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  static const name = 'movie-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(movieId),
      ),
    );
  }
}

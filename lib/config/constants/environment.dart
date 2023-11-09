import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  //^ Dejo Configurado ApiKey_personal, por facilidad de revision
  static String theMovieDbKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'c517e987f05c52d873863f6591cbbb29';
}

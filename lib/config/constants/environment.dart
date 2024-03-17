import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class Environment {
  static final String theMovieDbApiKey =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'No ApiKey';
}

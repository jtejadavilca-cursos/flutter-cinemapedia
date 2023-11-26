import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static final String THE_MOVIEDB_KEY =
      dotenv.env['THE_MOVIEDB_KEY'] ?? 'No ApiKey';
}

import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:tmdb_demo_app/models/movie_detail_model.dart';
import 'package:tmdb_demo_app/models/upcoming_movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  final apiKey = "ae1826dd4260546c27ed92ec00bae8ae";
  final baseUrl = "https://api.themoviedb.org/3";
  final imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  Logger logger = Logger();

  Future<List<UpcomingMovieModel>?> getUpcomingMovies() async {
    http.Response response =
        await http.get(Uri.parse("$baseUrl/movie/upcoming?api_key=$apiKey"));

    logger.d(response.body);
    if (response.statusCode == 200) {
      List<UpcomingMovieModel> upcomingMovies = [];

      var jsonResponse = jsonDecode(response.body);
      logger.d(jsonResponse);
      var results = jsonResponse['results'];

      for (var result in results) {
        UpcomingMovieModel upcomingMovieModel =
            UpcomingMovieModel.fromJson(result);
        upcomingMovies.add(upcomingMovieModel);
      }
      return upcomingMovies;
    } else {
      return null;
    }
  }

  Future<MovieDetailModel?> getMovieDetail({required int movieId}) async {
    try {
      http.Response response =
          await http.get(Uri.parse("$baseUrl/movie/$movieId?api_key=$apiKey"));

      logger.d(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        logger.d(jsonResponse);
        MovieDetailModel movieDetailModel =
            MovieDetailModel.fromJson(jsonResponse);

        return movieDetailModel;
      } else {
        return null;
      }
    } catch (e, st) {
      logger.e(e);
      logger.e(st);
      rethrow;
    }
  }
}

import 'dart:convert';

import 'package:tmdb_demo_app/models/upcoming_movie_model.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  final apiKey = "e28a4c17944e58f941e810e99e67c6a0";
  final baseUrl = "https://api.themoviedb.org/3";

  Future<List<UpcomingMovieModel>?> getUpcomingMovies() async {
    http.Response response =
        await http.get(Uri.parse("$baseUrl/movie/upcoming?$apiKey"));

    if (response.statusCode == 200) {
      List<UpcomingMovieModel> upcomingMovies = [];

      var jsonResponse = jsonDecode(response.body);

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
}

import 'dart:convert';

import 'package:flutter_minimalist_movie/services/api_key.dart';

import '../models/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static const baseUrl = 'https://api.themoviedb.org/3/discover/movie';
  final String apiKey;

  MovieService(this.apiKey);

  Future<Movie> getMovieByYear(int year) async {
    Map<String, dynamic> options = {
      'method': 'GET',
      'headers': {
        'accept': 'application/json',
        'Authorization': bearer
      }
    };

    final url = Uri.parse(
        'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&primary_release_date.gte=2022-01-01&primary_release_date.lte=2023-01-01&sort_by=vote_average.desc&vote_count.gte=5000');

    final response = await http.get(url, headers: options['headers']);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception(
          'Failed to load data. status code : ${response.statusCode}');
    }
  }
}

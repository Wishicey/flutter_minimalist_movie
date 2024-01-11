import 'package:flutter/material.dart';
import 'package:flutter_minimalist_movie/services/api_key.dart';
import 'package:flutter_minimalist_movie/services/movie_service.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

import '../models/movie_model.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _movieService = MovieService(apiKey);
  final _baseUrlImage = 'https://image.tmdb.org/t/p/original';
  Movie? _movie;

  _fetchMovieByYear() async {
    try {
      int year = 2022;
      final movie = await _movieService.getMovieByYear(year);
      setState(() {
        _movie = movie;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _fetchMovieByYear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropShadowImage(
              offset: const Offset(10, 10),
              scale: 1,
              blurRadius: 10,
              borderRadius: 20,
              image: Image.network(
                '$_baseUrlImage${_movie?.posterPath ?? ''}',
                width: 250,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 48, 0, 8),
              child: Text(
                _movie?.title ?? 'Chargement du film...',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            Text(
              _movie?.voteAverage.toString() ?? '0',
              style: const TextStyle(
                  color: Colors.green,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

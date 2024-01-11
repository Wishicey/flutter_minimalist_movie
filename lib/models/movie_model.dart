class Movie {
  final String title;
  final double voteAverage;
  final String posterPath;

  Movie(
      {required this.title,
      required this.voteAverage,
      required this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['results'][0]['title'],
        voteAverage: json['results'][0]['vote_average'],
        posterPath: json['results'][0]['poster_path']);
  }
}

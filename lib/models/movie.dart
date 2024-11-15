class Movie {
  int id;
  String title;
  double? voteAverage;
  String posterPath;
  String deskripsi;
  int stock;
  String penerbit;
  String pengarang;
  Movie({
    required this.id,
    required this.title,
    this.voteAverage,
    required this.posterPath,
    required this.deskripsi,
    required this.stock,
    required this.penerbit,
    required this.pengarang,
  });
}

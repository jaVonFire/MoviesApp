import 'dart:convert';


GenreResponse genreResponseFromJson(String str) => GenreResponse.fromJson(json.decode(str));

String genreResponseToJson(GenreResponse data) => json.encode(data.toJson());

class GenreResponse {
    int page;
    List<MovieGenre> results;
    int totalPages;
    int totalResults;

    GenreResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory GenreResponse.fromJson(Map<String, dynamic> json) => GenreResponse(
        page: json["page"],
        results: List<MovieGenre>.from(json["results"].map((x) => MovieGenre.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class MovieGenre {
    bool adult;
    String? backdropPath;
    List<int> genreIds;
    int id;
    OriginalLanguage? originalLanguage;
    String originalTitle;
    String overview;
    double popularity;
    String? posterPath;
    DateTime? releaseDate;
    String title;
    bool video;
    double voteAverage;
    int voteCount;

    String? heroId;

    get fullPosterImg {

      if ( posterPath != null ) {  
        return 'https://image.tmdb.org/t/p/w500$posterPath';
      } else {
        return 'https://i.stack.imgur.com/GNhxO.png';
      }
      
    }

    get fullBackdropPath {

      if ( backdropPath != null ) {  
        return 'https://image.tmdb.org/t/p/w500$backdropPath';
      } else {
        return 'https://i.stack.imgur.com/GNhxO.png';
      }
      
    }

    MovieGenre({
        required this.adult,
        required this.backdropPath,
        required this.genreIds,
        required this.id,
        required this.originalLanguage,
        required this.originalTitle,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.releaseDate,
        required this.title,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

      factory MovieGenre.fromJson(Map<String, dynamic> json) {
        DateTime? parseReleaseDate(String? date) {
          if (date == null || date.isEmpty) return null;
        try {
           return DateTime.parse(date);
        } catch (e) {
           return null;
        }
      }

      return MovieGenre(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: originalLanguageValues.map[json["original_language"]],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: parseReleaseDate(json["release_date"]),
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
    }

    Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguageValues.reverse[originalLanguage],
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate != null
            ? "${releaseDate?.year.toString().padLeft(4, '0')}-${releaseDate?.month.toString().padLeft(2, '0')}-${releaseDate?.day.toString().padLeft(2, '0')}"
            : null,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

enum OriginalLanguage {
    // ignore: constant_identifier_names
    EN,
    // ignore: constant_identifier_names
    FR,
    // ignore: constant_identifier_names
    JA,
    // ignore: constant_identifier_names
    NO
}

final originalLanguageValues = EnumValues({
    "en": OriginalLanguage.EN,
    "fr": OriginalLanguage.FR,
    "ja": OriginalLanguage.JA,
    "no": OriginalLanguage.NO
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
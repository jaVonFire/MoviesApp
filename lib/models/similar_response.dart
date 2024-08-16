import 'dart:convert';


SimilarResponse similarResponseFromJson(String str) => SimilarResponse.fromJson(json.decode(str));

String similarResponseToJson(SimilarResponse data) => json.encode(data.toJson());

class SimilarResponse {
    int page;
    List<Similar> results;
    int totalPages;
    int totalResults;

    SimilarResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory SimilarResponse.fromJson(Map<String, dynamic> json) => SimilarResponse(
        page: json["page"],
        results: List<Similar>.from(json["results"].map((x) => Similar.fromJson(x))),
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

class Similar {
    String? backdropPath;
    int id;
    String title;
    String originalTitle;
    String overview;
    String? posterPath;
    bool adult;
    String originalLanguage;
    List<int> genreIds;
    double popularity;
    DateTime releaseDate;
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

    Similar({
        required this.backdropPath,
        required this.id,
        required this.title,
        required this.originalTitle,
        required this.overview,
        required this.posterPath,
        required this.adult,
        required this.originalLanguage,
        required this.genreIds,
        required this.popularity,
        required this.releaseDate,
        required this.video,
        required this.voteAverage,
        required this.voteCount,
    });

    factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        title: json["title"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        adult: json["adult"],
        originalLanguage: json["original_language"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        popularity: json["popularity"]?.toDouble(),
        releaseDate: DateTime.parse(json["release_date"]),
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "title": title,
        "original_title": originalTitle,
        "overview": overview,
        "poster_path": posterPath,
        "adult": adult,
        "original_language": originalLanguage,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "popularity": popularity,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}

enum MediaType {
    MOVIE
}


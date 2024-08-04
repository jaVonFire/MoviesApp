import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier { // ChangeNotifier is a identificator of an API response

  final String _apiKey = 'd1ac5c8bea4874cb1ddb7941b40aba63';
  final String _baseUrl = 'api.themoviedb.org';
  final String _language = 'es-MX'; // Mexican Voices

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  Map<int, List<MovieGenre>> genreMovies = {};

  Map<String, dynamic> onKeyVideoMovies = {};
  Map<int, List<Cast>> onMovieCast = {};
  
  int _popularPage = 0;
  Map<int, int> genrePages = {};
          
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500)
  );

  final StreamController<List<Movie>> _suggestionsStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionsStream => _suggestionsStreamController.stream;

  MoviesProvider() {
    // ignore: avoid_print
    print('MoviesProvider Initialized');

    getOnDisplayMovies();
    getOnPopularMovies();
    initializeGenres();

  }

  Future<String> _getJsonData( String segment, [int page = 1, String? optionalParams] ) async {

    final url = Uri.https( _baseUrl, segment, {
      'api_key' : _apiKey,
      'language' : _language,
      'page' : '$page', 
      if (optionalParams != null) 'with_genres': optionalParams
  });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;

  }

  getOnDisplayMovies() async {

    final jsonData = await _getJsonData( '3/movie/now_playing' );
    final nowPlayingResponse = NowPlayingResponse.fromJson(json.decode(jsonData));

    onDisplayMovies = nowPlayingResponse.results; // Compatible
    notifyListeners(); // ChangeNotifier function
    
  }
  
  getOnPopularMovies() async {

    _popularPage++;

    final jsonData = await _getJsonData( '3/movie/popular', _popularPage );
    final popularResponse = PopularResponse.fromJson(json.decode(jsonData));

    onPopularMovies = [...onPopularMovies, ...popularResponse.results]; // Compatible
   
    notifyListeners(); // ChangeNotifier function

  }

  getOnGenreMovies( int genreId ) async {

    genrePages[genreId] = (genrePages[genreId] ?? 0) + 1;

    final jsonData = await _getJsonData( '3/discover/movie', genrePages[genreId]!, '$genreId'  );
    final genreMovieResponse = GenreResponse.fromJson(json.decode(jsonData));
    genreMovies[genreId] = [...(genreMovies[genreId] ?? []), ...genreMovieResponse.results]; // Compatible

    notifyListeners();

  }

  Future<List<Video>> getKeyVideoMovies( int movieId ) async {

    if ( onKeyVideoMovies.containsKey(movieId) ) return onKeyVideoMovies[movieId]!;

    final jsonData = await _getJsonData( '3/movie/$movieId/videos' );
    final videoResponse = VideoResponse.fromJson(json.decode(jsonData));

    onKeyVideoMovies['$movieId'] = videoResponse.results;

    return videoResponse.results;

  }

  Future<List<Cast>> getMovieCast( int movieId ) async {

    if ( onMovieCast.containsKey(movieId) ) return onMovieCast[movieId]!;

    final jsonData = await _getJsonData( '3/movie/$movieId/credits' );
    final creditsResponse = CreditsResponse.fromJson(json.decode(jsonData));

    onMovieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  Future<List<Movie>> getSearchMovie( String query, [int page = 1] ) async {

    final url = Uri.https( _baseUrl, '3/search/movie', {
      'api_key' : _apiKey,
      'language' : _language,
      'page' : '$page',
      'query' : query
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(json.decode(response.body));

    return searchResponse.results;

  }

  void getSuggestionsByQuery( String searchTerm ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final results = await getSearchMovie(value);
      _suggestionsStreamController.add(results);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), ( _ ) { 
      debouncer.value = searchTerm;
    });

  Future.delayed(const Duration(milliseconds: 301)).then(( _ ) => timer.cancel());

  }

  void initializeGenres() {
    getOnGenreMovies(16); 
    getOnGenreMovies(27); 
    getOnGenreMovies(10751);
    getOnGenreMovies(28);
    getOnGenreMovies(35);
    getOnGenreMovies(878);
    getOnGenreMovies(10749);
    getOnGenreMovies(53);
    getOnGenreMovies(18);
    getOnGenreMovies(99);
  }

}
import 'package:flutter/material.dart';


import 'package:movies_app/widgets/widgets.dart';

class SimilarMoviesScreen extends StatelessWidget {

  const SimilarMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final movieId = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Similares'),
        centerTitle: true,
      ),
      body: SimilarMovieCards(
        movieId: movieId!
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../search/search_delegate.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context); // Go to Widgets Tree, take me MoviesProvider's instance and throw it here

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Movies on Cinema'),
        ),
        actions: [
          IconButton(
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()) , 
            icon: const Icon(Icons.search_outlined)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            // Principal Cards
            CardSwiper( movies: moviesProvider.onDisplayMovies ),

            // Movies Slider
            MovieSlider( 
              movies: moviesProvider.onPopularMovies, 
              title: 'Populars',
              onNextPage: () => moviesProvider.getOnPopularMovies(), 
            )
        
          ],
        ),
      )
    );
  } 
}
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
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, 'settings'), 
          icon: const Icon(Icons.settings)
        ),   
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.movie),
            Text('  Movies App  ', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold )),
            Icon(Icons.movie)
          ],
        ),
        actions: [
            IconButton(
              onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()), 
              icon: const Icon(Icons.search_outlined)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
        
            // Principal Cards
            CardSwiper( movies: moviesProvider.onDisplayMovies ),

            const SizedBox( height: 10 ),       
            const Divider(),
        
            // Movies Slider
            MovieSlider( 
              movies: moviesProvider.onPopularMovies, 
              title: 'Todas las películas',
              onNextPage: () => moviesProvider.getOnPopularMovies(), 
            )
        
          ],
        ),
      )
    );
  } 
}
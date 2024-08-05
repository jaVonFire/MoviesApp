import 'package:flutter/material.dart';

import 'package:movies_app/models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
   
  const DetailsScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)!.settings.arguments;
    
    if ( arguments is Movie ) {
      return _MovieDetails( movieM: arguments);
    } else if ( arguments is MovieGenre ) {
      return _MovieGenreDetails( movieG: arguments );
    } else {
      return Scaffold(
        body: Container(),
      );
    }

  }
}

class _MovieDetails extends StatelessWidget {

  const _MovieDetails({required this.movieM,});

  final Movie movieM;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [ // Widgets with aditional behavior while scrolling 
          _CustomAppBar( movie: movieM ),
          SliverList( // Allow put widgets inside
            delegate: SliverChildListDelegate([ 
                _PosterAndTitle( movie: movieM ), // Normal widget, No-Sliver Widget
                _Overview( movie: movieM ),
                
                VideoPlayer( movieId: movieM.id ),
    
                const SizedBox( height: 20 ),
                
                CastingCards( movieId: movieM.id )
              ]
            ),
          )
        ],
      ),
    
    );
  }
}

class _MovieGenreDetails extends StatelessWidget {

  const _MovieGenreDetails({required this.movieG,});

  final MovieGenre movieG;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [ // Widgets with aditional behavior while scrolling 
          _CustomAppBar( movie: movieG ),
          SliverList( // Allow put widgets inside
            delegate: SliverChildListDelegate([ 
                _PosterAndTitle( movie: movieG ), // Normal widget, No-Sliver Widget
                _Overview( movie: movieG ),
                
                VideoPlayer( movieId: movieG.id ),
    
                const SizedBox( height: 20 ),
                
                CastingCards( movieId: movieG.id )
              ]
            ),
          )
        ],
      ),
    
    );
  }
}


class _CustomAppBar extends StatelessWidget {

  final dynamic movie;

  const _CustomAppBar({required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar( // Container
        titlePadding: const EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
          color: Colors.black12,
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          padding: const EdgeInsets.all( 10 ),
          child: Text( movie.title, style: const TextStyle( fontSize: 20 ), textAlign: TextAlign.center,)
          ),

        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'), 
          image: NetworkImage( movie.fullBackdropPath ),
          fit: BoxFit.cover,
        ),
      ),
       
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final dynamic movie;

  const _PosterAndTitle({required this.movie});

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric( horizontal: 20 ),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage( movie.fullPosterImg ),
                height: 150,
              ),
            ),
          ),
          
          const SizedBox( width: 20 ),

          ConstrainedBox(
            constraints: BoxConstraints( maxWidth: size.width - 200 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( movie.title , style: textTheme.headlineMedium, overflow: TextOverflow.ellipsis, maxLines: 2),
                Text( movie.originalTitle , style: const TextStyle( fontSize: 15, fontStyle: FontStyle.italic ), overflow: TextOverflow.ellipsis, maxLines: 2 ),
                Row(
                  children: [
                    const Icon(Icons.star_border_outlined, size: 20, color: Colors.grey),
                    const SizedBox( width: 5 ),
                    Text( '${movie.voteAverage}' , style: textTheme.bodySmall)
                  ]
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  
  final dynamic movie;

  const _Overview({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 20 ),
      child: Text ( movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
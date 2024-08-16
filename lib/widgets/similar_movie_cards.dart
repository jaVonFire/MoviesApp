import 'package:flutter/cupertino.dart';

import 'package:movies_app/providers/providers.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class SimilarMovieCards extends StatelessWidget {

  final Object movieId;

  const SimilarMovieCards({
    super.key,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getSimilarMovies(movieId as int),
      builder: (_, AsyncSnapshot<List<Similar>> snapshot) {

        if (!snapshot.hasData) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 200,
              child: const CupertinoActivityIndicator(),
            ),
          );
        }

        final List<Similar> similar = snapshot.data!;

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            mainAxisExtent: 230
          ),
          itemCount: similar.length, 
          itemBuilder: ( _ , index ) => _SimilarCard(similar: similar[index])
        );
      }
    );

  }
}

class _SimilarCard extends StatelessWidget {

  final Similar similar;

  const _SimilarCard({required this.similar});

  @override
  Widget build(BuildContext context) {

    similar.heroId = 'similar-${similar.id}';

    return Container(
      padding: const EdgeInsets.only( top: 25, left: 10, bottom: 10, right: 10 ),
      width: 110,
      height: 120,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: similar),
            child: Hero(
              tag: similar.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage( similar.fullBackdropPath ), // TODO: Probar si sirve
                  height: 150,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
      
          const SizedBox( height: 2 ),
      
          Text( 
            similar.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
      
        ],
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProdiver = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProdiver.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 150),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          }

          final List<Cast> cast = snapshot.data!;

          return Stack(
              children: [

              Container(
                height: 205,
                width: double.infinity,
                color: const Color.fromARGB(151, 192, 192, 192),
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: Container(
                  height: 15,
                  margin: const EdgeInsets.only( top: 205 ),
                  width: double.infinity,
                  color: const Color.fromARGB(151, 192, 192, 192),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(bottom: 30),
                padding: const EdgeInsets.only(top: 20),
                width: double.infinity, // Full width from father
                height: 200,
                child: ListView.builder(
                    itemCount: cast.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, int index) => _CastCard(actor: cast[index])),
              ),
            ]
          );
        }
      );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard({required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage( actor.fullProfilePath ),
              height: 130,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:movies_app/models/models.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> movies;

  const CardSwiper({
    Key? key, 
    required this.movies
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // ignore: prefer_is_empty
    if ( movies.length == 0 ) { 
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.55,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Más recientes',
            style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold ),
          ),
        ),
        SizedBox(
          // Better than Container
          width: double.infinity,
          height: size.height * 0.45,
          child: Swiper(
            itemCount: movies.length,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.6,
            itemHeight: size.width * 0.9,
            itemBuilder: (context, index) {
        
              final movie = movies[index];
        
              movie.heroId = 'swipper-${movie.id}';
        
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'details', arguments: movie ),
                child: Hero(
                  tag: movie.heroId!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30), // Allow for ClipRRect
                    child: FadeInImage(
                      placeholder: const AssetImage('assets/no-image.jpg'),
                      image: NetworkImage( movie.fullPosterImg ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import 'package:movies_app/models/models.dart';

class MovieGenreSlider extends StatefulWidget {

  final List<MovieGenre> movies;
  final String? title;
  final Function onNextPage;

  const MovieGenreSlider({super.key, required this.movies, this.title, required this.onNextPage});

  @override
  State<MovieGenreSlider> createState() => _MovieGenreSliderState();
}

class _MovieGenreSliderState extends State<MovieGenreSlider> {
  
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {

      if ( scrollController.position.pixels + 500 >= scrollController.position.maxScrollExtent ) {
      
      widget.onNextPage();

      }

    });

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 380,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

          if ( widget.title != null )

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('${widget.title}', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
              ),
            ),

            const SizedBox( height: 5 ),


            Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.movies.length,
                  itemBuilder: 
                  (context, int index) {  

                    final onlyMovie = widget.movies[index]; 

                    return _MoviePoster(movie: onlyMovie, title: onlyMovie.title, heroId: '${widget.title}-$index-${widget.movies[index].id}');
                    
              }),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final MovieGenre  movie;
  final String? title;
  final String heroId;

  const _MoviePoster({required this.movie, this.title, required this.heroId});

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    return Container(
      width: 170,
      margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: movie ),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  height: 225,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          if ( title != null )

          Text(
            '$title',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

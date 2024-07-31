import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:movies_app/models/models.dart';
import 'package:movies_app/providers/providers.dart';


class VideoPlayer extends StatefulWidget {

  final int movieId;

  const VideoPlayer({super.key, required this.movieId});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  YoutubePlayerController? _youtubePlayerController;
  late Future<List<Result>> _videoFuture;

  @override
  void initState() {
    super.initState();

    _videoFuture = Provider.of<MoviesProvider>(context, listen: false).getKeyVideoMovies(widget.movieId);
    
  }

    @override
    void dispose() {
      _youtubePlayerController?.dispose();
      super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _videoFuture, 
      builder: ( _ , AsyncSnapshot<List<Result>> snapshot ) {

        if ( !snapshot.hasData ) {
            return Container(
              constraints: const BoxConstraints( maxWidth: 150 ),
              height: 180,
              child: Container(),
            );
          } 

        final List<Result> video = snapshot.data!;

        if ( video.isEmpty ) { 
          return _NoData(); 
        }

        String videoKey() {
          for (var element in video) {
            if ( element.type == "Trailer" ) {
              final name = element.name.toLowerCase();
              if ( name.contains('trailer') || name.contains('tráiler') ) {
                return element.key;
              }
            } else if ( element.type == "Teaser" ) {
              return element.key;
            }
          }
            return '';
        }

        _youtubePlayerController = YoutubePlayerController(
          initialVideoId: videoKey(),
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            isLive: false,
            loop: true
          )
        );

        return Container(
          padding: const EdgeInsets.only( top: 20, left: 20, right: 20 ),
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _youtubePlayerController!,
              showVideoProgressIndicator: true,
              // TODO: Fullscreen correctamente
            ), 
            builder: ( context , player ) {
              return Container(
                child: player,
              );
            }
          ),
        );
        
      }
    );

  }
}

class _NoData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: AssetImage( 'assets/video-not-working.png' ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
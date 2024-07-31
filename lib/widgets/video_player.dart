import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _videoFuture, 
      builder: ( _ , AsyncSnapshot<List<Result>> snapshot ) {

        if ( !snapshot.hasData ) {
            return Container(
              constraints: const BoxConstraints( maxWidth: 150 ),
              height: 180,
              child: const CupertinoActivityIndicator(),
            );
          } 

        final List<Result> video = snapshot.data!;
        // if ( video.isEmpty ) { return const Text('NO DATA'); }
        print(video);

        _youtubePlayerController = YoutubePlayerController(
          initialVideoId: video[0].key,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            isLive: false,
            loop: true
          )
        );

        return YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _youtubePlayerController!,
            showVideoProgressIndicator: true,
          ), 
          builder: ( context , player ) {
            return Container(
              child: player,
            );
          }
        );
        
      }
    );
  }
}
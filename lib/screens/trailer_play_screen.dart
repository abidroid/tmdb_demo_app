import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_demo_app/blocs/trailer/trailer_bloc.dart';
import 'package:tmdb_demo_app/models/trailer_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerPlayScreen extends StatefulWidget {
  final int movieId;
  const TrailerPlayScreen({super.key, required this.movieId});

  @override
  State<TrailerPlayScreen> createState() => _TrailerPlayScreenState();
}

class _TrailerPlayScreenState extends State<TrailerPlayScreen> {
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    context.read<TrailerBloc>().add(FetchTrailerEvent(
          movieId: widget.movieId,
        ));
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TrailerBloc, TrailerState>(builder: (context, state) {
        if (state is TrailerLoading) {
          return const Center(
            child: SpinKitDualRing(color: Colors.blue),
          );
        }

        if (state is TrailerError) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is TrailerLoaded) {
          TrailerModel? trailerModel = state.trailerModel;

          if (trailerModel == null) {
            return const Center(
              child: Text('Couldn\'t load movie trailer'),
            );
          }

          // return youtube player

          // Initialize the YouTube Player Controller with the trailer key
          _youtubeController = YoutubePlayerController(
            initialVideoId: trailerModel.key!,
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          );

          // Listen for the end of the video
          _youtubeController!.addListener(() {
            if (_youtubeController!.value.playerState == PlayerState.ended) {
              Navigator.pop(context); // Return to the previous screen
            }
          });

          return YoutubePlayer(
            controller: _youtubeController!,
            showVideoProgressIndicator: true,
            onEnded: (_) => Navigator.pop(context),
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }
}

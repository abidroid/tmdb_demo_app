import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_demo_app/blocs/trailer/trailer_bloc.dart';
import 'package:tmdb_demo_app/models/trailer_model.dart';

class TrailerPlayScreen extends StatefulWidget {
  final int movieId;
  const TrailerPlayScreen({super.key, required this.movieId});

  @override
  State<TrailerPlayScreen> createState() => _TrailerPlayScreenState();
}

class _TrailerPlayScreenState extends State<TrailerPlayScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TrailerBloc>().add(FetchTrailerEvent(
          movieId: widget.movieId,
        ));
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
        }

        return const SizedBox.shrink();
      }),
    );
  }
}

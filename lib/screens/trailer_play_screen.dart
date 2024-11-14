import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_demo_app/blocs/trailer/trailer_bloc.dart';

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
      body: Placeholder(),
    );
  }
}

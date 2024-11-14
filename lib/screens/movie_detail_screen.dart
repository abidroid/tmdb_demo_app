import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:tmdb_demo_app/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:tmdb_demo_app/models/movie_detail_model.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Logger logger = Logger();
  @override
  void initState() {
    super.initState();

    logger.d("*****************************");
    logger.d(widget.movieId);
    context
        .read<MovieDetailBloc>()
        .add(LoadMovieDetail(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
        if (state is LoadMovieDetail) {
          return const Center(
            child: SpinKitDualRing(color: Colors.blue),
          );
        }
        if (state is MovieDetailErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is LoadedMovieDetail) {
          MovieDetailModel? movieDetailModel = state.movieDetailModel;

          if (movieDetailModel == null) {
            return const Center(
              child: Text('Couldn\'t load movie details'),
            );
          }

          return Column(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Image.network(
                      'https://image.tmdb.org/t/p/w500/${movieDetailModel.posterPath!}')
                ],
              ))
            ],
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:tmdb_demo_app/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:tmdb_demo_app/models/movie_detail_model.dart';
import 'package:tmdb_demo_app/screens/trailer_play_screen.dart';

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
        if (state is LoadingMovieDetail) {
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
                flex: 7,
                child: Stack(
                  children: [
                    Image.network(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        'https://image.tmdb.org/t/p/w500/${movieDetailModel.backdropPath!}'),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'In Theatres on ${movieDetailModel.releaseDate}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 240,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyan,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text('Get Tickets',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF))),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 240,
                            height: 50,
                            child: OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                //backgroundColor: Colors.cyan,
                                side: const BorderSide(
                                    color: Colors.cyan,
                                    width: 1), // Outline color and width

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return TrailerPlayScreen(
                                      movieId: widget.movieId);
                                }));
                              },
                              icon: const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              label: const Text('Watch Trailer',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFFFFF))),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    //color: Colors.amber,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Genres',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: movieDetailModel.genres!.map((genre) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: getRandomColor(),
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  child: Text(
                                    genre.name ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ));
                            }).toList()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Overview',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            movieDetailModel.overview ?? '',
                            style: const TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Color getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255, // Full opacity
      random.nextInt(100), // Red (0–255)
      random.nextInt(100), // Green (0–255)
      random.nextInt(100), // Blue (0–255)
    );
  }
}

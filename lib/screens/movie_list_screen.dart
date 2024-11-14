import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_demo_app/blocs/bloc/upcoming_movies_bloc.dart';
import 'package:tmdb_demo_app/models/upcoming_movie_model.dart';
import 'package:tmdb_demo_app/screens/movie_detail_screen.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UpcomingMoviesBloc, UpcomingMoviesState>(
          builder: (context, state) {
        if (state is UpcomingMovieLoadingState) {
          return const Center(
            child: SpinKitDualRing(color: Colors.blue),
          );
        }

        if (state is UpcomingMovieErrorState) {
          return Center(
            child: Text(state.message),
          );
        }

        if (state is UpcomingMovieLoadedState) {
          List<UpcomingMovieModel>? upcomingMovies = state.movie;

          if (upcomingMovies == null) {
            return const Center(
              child: Text('Couldn\'t load movies'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  UpcomingMovieModel movie = upcomingMovies[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return MovieDetailScreen(movieId: movie.id!);
                      }));
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                            width: double.infinity,
                            height: 220,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'),
                            )),
                        Positioned(
                          left: 20,
                          bottom: 20,
                          child: Text(
                            movie.title ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount: upcomingMovies.length),
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }
}

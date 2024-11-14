import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_demo_app/models/upcoming_movie_model.dart';
import 'package:tmdb_demo_app/repository/movie_repository.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpcomingMoviesBloc
    extends Bloc<UpcomingMoviesEvent, UpcomingMoviesState> {
  final MovieRepository movieRepository = MovieRepository();

  UpcomingMoviesBloc() : super(UpcomingMoviesInitial()) {
    on<UpcomingMoviesEvent>((event, emit) async {
      if (event is LoadUpcomingMovies) {
        emit(UpcomingMovieLoadingState());

        try {
          List<UpcomingMovieModel>? upcomingMovies =
              await movieRepository.getUpcomingMovies();

          emit(UpcomingMovieLoadedState(movie: upcomingMovies));
        } catch (e) {
          emit(const UpcomingMovieErrorState(message: 'Something went wrong'));
        }
      }
    });
  }
}

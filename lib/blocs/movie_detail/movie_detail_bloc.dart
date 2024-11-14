import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_demo_app/models/movie_detail_model.dart';
import 'package:tmdb_demo_app/repository/movie_repository.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieRepository movieRepository = MovieRepository();
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailEvent>((event, emit) async {
      if (event is LoadMovieDetail) {
        emit(LoadingMovieDetail());

        try {
          MovieDetailModel? movieDetailModel =
              await movieRepository.getMovieDetail(movieId: event.movieId);

          emit(LoadedMovieDetail(movieDetailModel: movieDetailModel));
        } catch (e) {
          emit(const MovieDetailErrorState(message: 'Something went wrong'));
        }
      }
    });
  }
}

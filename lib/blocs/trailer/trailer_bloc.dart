import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_demo_app/models/trailer_model.dart';
import 'package:tmdb_demo_app/repository/movie_repository.dart';

part 'trailer_event.dart';
part 'trailer_state.dart';

class TrailerBloc extends Bloc<TrailerEvent, TrailerState> {
  final MovieRepository movieRepository = MovieRepository();
  TrailerBloc() : super(TrailerInitial()) {
    on<TrailerEvent>((event, emit) async {
      if (event is FetchTrailerEvent) {
        emit(TrailerLoading());

        try {
          TrailerModel? trailerModel =
              await movieRepository.getMovieTrailer(movieId: event.movieId);

          emit(TrailerLoaded(trailerModel: trailerModel));
        } catch (e) {
          emit(TrailerError(message: e.toString()));
        }
      }
    });
  }
}

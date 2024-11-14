part of 'trailer_bloc.dart';

sealed class TrailerEvent extends Equatable {
  const TrailerEvent();

  @override
  List<Object> get props => [];
}

class FetchTrailerEvent extends TrailerEvent {
  final int movieId;

  const FetchTrailerEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}

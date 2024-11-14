part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

class LoadingMovieDetail extends MovieDetailState {}

class LoadedMovieDetail extends MovieDetailState {
  final MovieDetailModel? movieDetailModel;

  const LoadedMovieDetail({this.movieDetailModel});
}

class MovieDetailErrorState extends MovieDetailState {
  final String message;

  const MovieDetailErrorState({required this.message});
}

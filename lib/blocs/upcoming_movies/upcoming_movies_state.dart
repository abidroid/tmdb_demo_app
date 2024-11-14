part of 'upcoming_movies_bloc.dart';

sealed class UpcomingMoviesState extends Equatable {
  const UpcomingMoviesState();

  @override
  List<Object> get props => [];
}

final class UpcomingMoviesInitial extends UpcomingMoviesState {}

class UpcomingMovieLoadingState extends UpcomingMoviesState {}

class UpcomingMovieLoadedState extends UpcomingMoviesState {
  final List<UpcomingMovieModel>? movie;

  const UpcomingMovieLoadedState({this.movie});
}

class UpcomingMovieErrorState extends UpcomingMoviesState {
  final String message;

  const UpcomingMovieErrorState({required this.message});
}

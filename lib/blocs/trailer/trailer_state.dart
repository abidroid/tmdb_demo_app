part of 'trailer_bloc.dart';

sealed class TrailerState extends Equatable {
  const TrailerState();

  @override
  List<Object?> get props => [];
}

final class TrailerInitial extends TrailerState {}

class TrailerLoading extends TrailerState {}

class TrailerLoaded extends TrailerState {
  final TrailerModel? trailerModel;

  const TrailerLoaded({this.trailerModel});

  @override
  List<Object?> get props => [trailerModel];
}

class TrailerError extends TrailerState {
  final String message;

  const TrailerError({required this.message});

  @override
  List<Object> get props => [message];
}

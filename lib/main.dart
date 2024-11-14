import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_demo_app/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:tmdb_demo_app/blocs/trailer/trailer_bloc.dart';
import 'package:tmdb_demo_app/blocs/upcoming_movies/upcoming_movies_bloc.dart';
import 'package:tmdb_demo_app/screens/movie_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpcomingMoviesBloc()..add(LoadUpcomingMovies()),
        ),
        BlocProvider(
          create: (context) => MovieDetailBloc(),
        ),
        BlocProvider(
          create: (context) => TrailerBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MovieListScreen(),
      ),
    );
  }
}

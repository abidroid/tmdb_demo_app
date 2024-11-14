import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb_demo_app/blocs/bloc/upcoming_movies_bloc.dart';
import 'package:tmdb_demo_app/screens/movie_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  UpcomingMoviesBloc()..add(LoadUpcomingMovies())),
        ],
        child: const MovieListScreen(),
      ),
    );
  }
}

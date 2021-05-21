import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';

import 'schema/movie.pbgrpc.dart';

abstract class MovieState {}

class MovieInit extends MovieState {}

class MovieSuccess extends MovieState {
  final List<Movie> movies;

  MovieSuccess(this.movies);
}

class MovieFailure extends MovieState {
  final String message;

  MovieFailure(this.message);
}

class MovieProgress extends MovieState {}

class MovieService extends ValueNotifier<MovieState> {
  final ClientChannel client;

  MovieService({this.client}) : super(MovieInit());

  set handle(MovieEvent event) => event.execute(this);
}

abstract class MovieEvent {
  void execute(MovieService service);
}

class SearchMovies extends MovieEvent {
  final String query;

  SearchMovies(this.query);

  @override
  Future<void> execute(MovieService service) async {
    var client = MovieServiceClient(service.client);
    try {
      service.value = MovieProgress();
      var response = await client.listMovies(ListMoviesRequest(query: query));
      service.value = MovieSuccess(response.movies);
    } catch (e) {
      log(e.toString());
      service.value = MovieFailure(
        "Veillez verifier votre connexion",
      );
    }
  }
}

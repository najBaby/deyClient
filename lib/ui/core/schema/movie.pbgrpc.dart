///
//  Generated code. Do not modify.
//  source: movie.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'movie.pb.dart' as $0;
export 'movie.pb.dart';

class MovieServiceClient extends $grpc.Client {
  static final _$listMovies =
      $grpc.ClientMethod<$0.ListMoviesRequest, $0.ListMoviesResponse>(
          '/google.api.MovieService/ListMovies',
          ($0.ListMoviesRequest value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.ListMoviesResponse.fromBuffer(value));
  static final _$movie = $grpc.ClientMethod<$0.MovieRequest, $0.MovieResponse>(
      '/google.api.MovieService/Movie',
      ($0.MovieRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.MovieResponse.fromBuffer(value));

  MovieServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.ListMoviesResponse> listMovies(
      $0.ListMoviesRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$listMovies, request, options: options);
  }

  $grpc.ResponseFuture<$0.MovieResponse> movie($0.MovieRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$movie, request, options: options);
  }
}

abstract class MovieServiceBase extends $grpc.Service {
  $core.String get $name => 'google.api.MovieService';

  MovieServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ListMoviesRequest, $0.ListMoviesResponse>(
        'ListMovies',
        listMovies_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListMoviesRequest.fromBuffer(value),
        ($0.ListMoviesResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.MovieRequest, $0.MovieResponse>(
        'Movie',
        movie_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.MovieRequest.fromBuffer(value),
        ($0.MovieResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.ListMoviesResponse> listMovies_Pre($grpc.ServiceCall call,
      $async.Future<$0.ListMoviesRequest> request) async {
    return listMovies(call, await request);
  }

  $async.Future<$0.MovieResponse> movie_Pre(
      $grpc.ServiceCall call, $async.Future<$0.MovieRequest> request) async {
    return movie(call, await request);
  }

  $async.Future<$0.ListMoviesResponse> listMovies(
      $grpc.ServiceCall call, $0.ListMoviesRequest request);
  $async.Future<$0.MovieResponse> movie(
      $grpc.ServiceCall call, $0.MovieRequest request);
}

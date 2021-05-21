///
//  Generated code. Do not modify.
//  source: movie.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'movie.pbenum.dart';

export 'movie.pbenum.dart';

class Movie extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Movie', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'image')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'video')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hoster')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subtitle')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'synopsis')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'language')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'production')
    ..e<Movie_Category>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'category', $pb.PbFieldType.OE, defaultOrMaker: Movie_Category.FILM, valueOf: Movie_Category.valueOf, enumValues: Movie_Category.values)
    ..pPS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'genres')
    ..hasRequiredFields = false
  ;

  Movie._() : super();
  factory Movie({
    $core.String? title,
    $core.String? image,
    $core.String? video,
    $core.String? hoster,
    $core.String? source,
    $core.String? subtitle,
    $core.String? synopsis,
    $core.String? language,
    $core.String? production,
    Movie_Category? category,
    $core.Iterable<$core.String>? genres,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (image != null) {
      _result.image = image;
    }
    if (video != null) {
      _result.video = video;
    }
    if (hoster != null) {
      _result.hoster = hoster;
    }
    if (source != null) {
      _result.source = source;
    }
    if (subtitle != null) {
      _result.subtitle = subtitle;
    }
    if (synopsis != null) {
      _result.synopsis = synopsis;
    }
    if (language != null) {
      _result.language = language;
    }
    if (production != null) {
      _result.production = production;
    }
    if (category != null) {
      _result.category = category;
    }
    if (genres != null) {
      _result.genres.addAll(genres);
    }
    return _result;
  }
  factory Movie.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Movie.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Movie clone() => Movie()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Movie copyWith(void Function(Movie) updates) => super.copyWith((message) => updates(message as Movie)) as Movie; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Movie create() => Movie._();
  Movie createEmptyInstance() => create();
  static $pb.PbList<Movie> createRepeated() => $pb.PbList<Movie>();
  @$core.pragma('dart2js:noInline')
  static Movie getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Movie>(create);
  static Movie? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get image => $_getSZ(1);
  @$pb.TagNumber(2)
  set image($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearImage() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get video => $_getSZ(2);
  @$pb.TagNumber(3)
  set video($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVideo() => $_has(2);
  @$pb.TagNumber(3)
  void clearVideo() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get hoster => $_getSZ(3);
  @$pb.TagNumber(4)
  set hoster($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasHoster() => $_has(3);
  @$pb.TagNumber(4)
  void clearHoster() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get source => $_getSZ(4);
  @$pb.TagNumber(5)
  set source($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSource() => $_has(4);
  @$pb.TagNumber(5)
  void clearSource() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get subtitle => $_getSZ(5);
  @$pb.TagNumber(6)
  set subtitle($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSubtitle() => $_has(5);
  @$pb.TagNumber(6)
  void clearSubtitle() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get synopsis => $_getSZ(6);
  @$pb.TagNumber(7)
  set synopsis($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasSynopsis() => $_has(6);
  @$pb.TagNumber(7)
  void clearSynopsis() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get language => $_getSZ(7);
  @$pb.TagNumber(8)
  set language($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasLanguage() => $_has(7);
  @$pb.TagNumber(8)
  void clearLanguage() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get production => $_getSZ(8);
  @$pb.TagNumber(9)
  set production($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasProduction() => $_has(8);
  @$pb.TagNumber(9)
  void clearProduction() => clearField(9);

  @$pb.TagNumber(10)
  Movie_Category get category => $_getN(9);
  @$pb.TagNumber(10)
  set category(Movie_Category v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasCategory() => $_has(9);
  @$pb.TagNumber(10)
  void clearCategory() => clearField(10);

  @$pb.TagNumber(11)
  $core.List<$core.String> get genres => $_getList(10);
}

class ListMoviesRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListMoviesRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'query')
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nextPage')
    ..aInt64(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'prevPage')
    ..hasRequiredFields = false
  ;

  ListMoviesRequest._() : super();
  factory ListMoviesRequest({
    $core.String? query,
    $fixnum.Int64? nextPage,
    $fixnum.Int64? prevPage,
  }) {
    final _result = create();
    if (query != null) {
      _result.query = query;
    }
    if (nextPage != null) {
      _result.nextPage = nextPage;
    }
    if (prevPage != null) {
      _result.prevPage = prevPage;
    }
    return _result;
  }
  factory ListMoviesRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListMoviesRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListMoviesRequest clone() => ListMoviesRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListMoviesRequest copyWith(void Function(ListMoviesRequest) updates) => super.copyWith((message) => updates(message as ListMoviesRequest)) as ListMoviesRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListMoviesRequest create() => ListMoviesRequest._();
  ListMoviesRequest createEmptyInstance() => create();
  static $pb.PbList<ListMoviesRequest> createRepeated() => $pb.PbList<ListMoviesRequest>();
  @$core.pragma('dart2js:noInline')
  static ListMoviesRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListMoviesRequest>(create);
  static ListMoviesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get nextPage => $_getI64(1);
  @$pb.TagNumber(2)
  set nextPage($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasNextPage() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextPage() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get prevPage => $_getI64(2);
  @$pb.TagNumber(3)
  set prevPage($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPrevPage() => $_has(2);
  @$pb.TagNumber(3)
  void clearPrevPage() => clearField(3);
}

class ListMoviesResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ListMoviesResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.api'), createEmptyInstance: create)
    ..pc<Movie>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'movies', $pb.PbFieldType.PM, subBuilder: Movie.create)
    ..pc<Movie>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'newsMovies', $pb.PbFieldType.PM, subBuilder: Movie.create)
    ..pc<Movie>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'popularsMovies', $pb.PbFieldType.PM, subBuilder: Movie.create)
    ..hasRequiredFields = false
  ;

  ListMoviesResponse._() : super();
  factory ListMoviesResponse({
    $core.Iterable<Movie>? movies,
    $core.Iterable<Movie>? newsMovies,
    $core.Iterable<Movie>? popularsMovies,
  }) {
    final _result = create();
    if (movies != null) {
      _result.movies.addAll(movies);
    }
    if (newsMovies != null) {
      _result.newsMovies.addAll(newsMovies);
    }
    if (popularsMovies != null) {
      _result.popularsMovies.addAll(popularsMovies);
    }
    return _result;
  }
  factory ListMoviesResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ListMoviesResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ListMoviesResponse clone() => ListMoviesResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ListMoviesResponse copyWith(void Function(ListMoviesResponse) updates) => super.copyWith((message) => updates(message as ListMoviesResponse)) as ListMoviesResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ListMoviesResponse create() => ListMoviesResponse._();
  ListMoviesResponse createEmptyInstance() => create();
  static $pb.PbList<ListMoviesResponse> createRepeated() => $pb.PbList<ListMoviesResponse>();
  @$core.pragma('dart2js:noInline')
  static ListMoviesResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ListMoviesResponse>(create);
  static ListMoviesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Movie> get movies => $_getList(0);

  @$pb.TagNumber(2)
  $core.List<Movie> get newsMovies => $_getList(1);

  @$pb.TagNumber(3)
  $core.List<Movie> get popularsMovies => $_getList(2);
}

class MovieRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MovieRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.api'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..hasRequiredFields = false
  ;

  MovieRequest._() : super();
  factory MovieRequest({
    $core.String? source,
  }) {
    final _result = create();
    if (source != null) {
      _result.source = source;
    }
    return _result;
  }
  factory MovieRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MovieRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MovieRequest clone() => MovieRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MovieRequest copyWith(void Function(MovieRequest) updates) => super.copyWith((message) => updates(message as MovieRequest)) as MovieRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MovieRequest create() => MovieRequest._();
  MovieRequest createEmptyInstance() => create();
  static $pb.PbList<MovieRequest> createRepeated() => $pb.PbList<MovieRequest>();
  @$core.pragma('dart2js:noInline')
  static MovieRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MovieRequest>(create);
  static MovieRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get source => $_getSZ(0);
  @$pb.TagNumber(1)
  set source($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasSource() => $_has(0);
  @$pb.TagNumber(1)
  void clearSource() => clearField(1);
}

class MovieResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MovieResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'google.api'), createEmptyInstance: create)
    ..aOM<Movie>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'movie', subBuilder: Movie.create)
    ..hasRequiredFields = false
  ;

  MovieResponse._() : super();
  factory MovieResponse({
    Movie? movie,
  }) {
    final _result = create();
    if (movie != null) {
      _result.movie = movie;
    }
    return _result;
  }
  factory MovieResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MovieResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MovieResponse clone() => MovieResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MovieResponse copyWith(void Function(MovieResponse) updates) => super.copyWith((message) => updates(message as MovieResponse)) as MovieResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MovieResponse create() => MovieResponse._();
  MovieResponse createEmptyInstance() => create();
  static $pb.PbList<MovieResponse> createRepeated() => $pb.PbList<MovieResponse>();
  @$core.pragma('dart2js:noInline')
  static MovieResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MovieResponse>(create);
  static MovieResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Movie get movie => $_getN(0);
  @$pb.TagNumber(1)
  set movie(Movie v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMovie() => $_has(0);
  @$pb.TagNumber(1)
  void clearMovie() => clearField(1);
  @$pb.TagNumber(1)
  Movie ensureMovie() => $_ensure(0);
}


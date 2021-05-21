///
//  Generated code. Do not modify.
//  source: movie.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Movie_Category extends $pb.ProtobufEnum {
  static const Movie_Category FILM = Movie_Category._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FILM');
  static const Movie_Category SERIE = Movie_Category._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SERIE');

  static const $core.List<Movie_Category> values = <Movie_Category> [
    FILM,
    SERIE,
  ];

  static final $core.Map<$core.int, Movie_Category> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Movie_Category? valueOf($core.int value) => _byValue[value];

  const Movie_Category._($core.int v, $core.String n) : super(v, n);
}


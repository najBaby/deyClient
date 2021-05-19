///
//  Generated code. Do not modify.
//  source: movie.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use movieDescriptor instead')
const Movie$json = const {
  '1': 'Movie',
  '2': const [
    const {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'image', '3': 2, '4': 1, '5': 9, '10': 'image'},
    const {'1': 'video', '3': 3, '4': 1, '5': 9, '10': 'video'},
    const {'1': 'hoster', '3': 4, '4': 1, '5': 9, '10': 'hoster'},
    const {'1': 'source', '3': 5, '4': 1, '5': 9, '10': 'source'},
    const {'1': 'subtitle', '3': 6, '4': 1, '5': 9, '10': 'subtitle'},
    const {'1': 'synopsis', '3': 7, '4': 1, '5': 9, '10': 'synopsis'},
    const {'1': 'category', '3': 8, '4': 1, '5': 14, '6': '.google.api.Movie.Category', '10': 'category'},
    const {'1': 'genres', '3': 9, '4': 3, '5': 9, '10': 'genres'},
  ],
  '4': const [Movie_Category$json],
};

@$core.Deprecated('Use movieDescriptor instead')
const Movie_Category$json = const {
  '1': 'Category',
  '2': const [
    const {'1': 'FILM', '2': 0},
    const {'1': 'SERIE', '2': 1},
  ],
};

/// Descriptor for `Movie`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List movieDescriptor = $convert.base64Decode('CgVNb3ZpZRIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSFAoFaW1hZ2UYAiABKAlSBWltYWdlEhQKBXZpZGVvGAMgASgJUgV2aWRlbxIWCgZob3N0ZXIYBCABKAlSBmhvc3RlchIWCgZzb3VyY2UYBSABKAlSBnNvdXJjZRIaCghzdWJ0aXRsZRgGIAEoCVIIc3VidGl0bGUSGgoIc3lub3BzaXMYByABKAlSCHN5bm9wc2lzEjYKCGNhdGVnb3J5GAggASgOMhouZ29vZ2xlLmFwaS5Nb3ZpZS5DYXRlZ29yeVIIY2F0ZWdvcnkSFgoGZ2VucmVzGAkgAygJUgZnZW5yZXMiHwoIQ2F0ZWdvcnkSCAoERklMTRAAEgkKBVNFUklFEAE=');
@$core.Deprecated('Use listMoviesRequestDescriptor instead')
const ListMoviesRequest$json = const {
  '1': 'ListMoviesRequest',
  '2': const [
    const {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    const {'1': 'next_page', '3': 2, '4': 1, '5': 3, '10': 'nextPage'},
    const {'1': 'prev_page', '3': 3, '4': 1, '5': 3, '10': 'prevPage'},
  ],
};

/// Descriptor for `ListMoviesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMoviesRequestDescriptor = $convert.base64Decode('ChFMaXN0TW92aWVzUmVxdWVzdBIUCgVxdWVyeRgBIAEoCVIFcXVlcnkSGwoJbmV4dF9wYWdlGAIgASgDUghuZXh0UGFnZRIbCglwcmV2X3BhZ2UYAyABKANSCHByZXZQYWdl');
@$core.Deprecated('Use listMoviesResponseDescriptor instead')
const ListMoviesResponse$json = const {
  '1': 'ListMoviesResponse',
  '2': const [
    const {'1': 'movies', '3': 1, '4': 3, '5': 11, '6': '.google.api.Movie', '10': 'movies'},
    const {'1': 'news_movies', '3': 2, '4': 3, '5': 11, '6': '.google.api.Movie', '10': 'newsMovies'},
    const {'1': 'populars_movies', '3': 3, '4': 3, '5': 11, '6': '.google.api.Movie', '10': 'popularsMovies'},
  ],
};

/// Descriptor for `ListMoviesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMoviesResponseDescriptor = $convert.base64Decode('ChJMaXN0TW92aWVzUmVzcG9uc2USKQoGbW92aWVzGAEgAygLMhEuZ29vZ2xlLmFwaS5Nb3ZpZVIGbW92aWVzEjIKC25ld3NfbW92aWVzGAIgAygLMhEuZ29vZ2xlLmFwaS5Nb3ZpZVIKbmV3c01vdmllcxI6Cg9wb3B1bGFyc19tb3ZpZXMYAyADKAsyES5nb29nbGUuYXBpLk1vdmllUg5wb3B1bGFyc01vdmllcw==');
@$core.Deprecated('Use movieRequestDescriptor instead')
const MovieRequest$json = const {
  '1': 'MovieRequest',
  '2': const [
    const {'1': 'source', '3': 1, '4': 1, '5': 9, '10': 'source'},
  ],
};

/// Descriptor for `MovieRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List movieRequestDescriptor = $convert.base64Decode('CgxNb3ZpZVJlcXVlc3QSFgoGc291cmNlGAEgASgJUgZzb3VyY2U=');
@$core.Deprecated('Use movieResponseDescriptor instead')
const MovieResponse$json = const {
  '1': 'MovieResponse',
  '2': const [
    const {'1': 'movie', '3': 1, '4': 1, '5': 11, '6': '.google.api.Movie', '10': 'movie'},
  ],
};

/// Descriptor for `MovieResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List movieResponseDescriptor = $convert.base64Decode('Cg1Nb3ZpZVJlc3BvbnNlEicKBW1vdmllGAEgASgLMhEuZ29vZ2xlLmFwaS5Nb3ZpZVIFbW92aWU=');

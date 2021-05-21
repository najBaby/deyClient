import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:grpc/grpc.dart' as grpc;
import 'package:fixnum/fixnum.dart';

import 'service/schema/movie.pbgrpc.dart';
import 'widgets.dart';
import 'article.dart';
import 'core/aspect.dart';

class SearchArticlesScaffold extends StatefulWidget {
  @override
  _SearchArticlesScaffoldState createState() => _SearchArticlesScaffoldState();
}

class _SearchArticlesScaffoldState extends State<SearchArticlesScaffold> {
  final client = MovieServiceClient(
    grpc.ClientChannel(
      "192.168.43.164",
      port: 9000,
      options: grpc.ChannelOptions(
        credentials: grpc.ChannelCredentials.insecure(),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    responseFuture = client.listMovies(
      ListMoviesRequest(nextPage: Int64(0)),
    );
  }

  @override
  void dispose() {
    super.dispose();
    responseFuture.cancel();
  }

  grpc.ResponseFuture<ListMoviesResponse> responseFuture;

  void fetchSearch(String query) {
    setState(() {
      responseFuture = client.listMovies(
        ListMoviesRequest(
          query: query,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var ratio = DeviceAspectRatio.of(context);

    return Scaffold(
      body: FutureBuilder<ListMoviesResponse>(
        future: responseFuture,
        builder: (context, snapshot) {
          var moviesResponse = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(10.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
            default:
          }

          var movies = moviesResponse.movies;
          return CustomScrollView(
            physics: AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                floating: true,
                titleSpacing: 8.0,
                toolbarHeight: 58.0,
                title: CupertinoSearchTextField(
                  onSubmitted: fetchSearch,
                  style: TextStyle(color: Colors.white),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8.0,
                  ),
                  placeholder: 'Rechercher',
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var movie = movies[index];
                      return MovieTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 400),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return ZoomPageTransitionsBuilder()
                                    .buildTransitions(
                                  null,
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  MovieScaffold(
                                    tag: "film $index",
                                    movie: movie,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        image: movie.image,
                        title: Text(
                          movie.title.toUpperCase(),
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Antonio',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          movie.subtitle.toUpperCase(),
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Antonio',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                    childCount: movies.length,
                  ),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: ratio.longestArea * 400,
                    crossAxisSpacing: 16.0,
                    childAspectRatio: 0.5,
                    mainAxisSpacing: 5.0,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

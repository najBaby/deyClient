import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:grpc/grpc.dart' as grpc;

import 'test.dart';
import 'core/aspect.dart';
import 'service/schema/movie.pbgrpc.dart';

class MovieScaffold extends StatelessWidget {
  final Object tag;
  final Movie movie;

  MovieScaffold({this.tag, this.movie});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var ratio = DeviceAspectRatio.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          _SliverAppBar(
            image: movie.image,
            title: movie.title,
          ),
          _Body(movie),
        ],
      ),
    );
  }
}

class _SliverAppBar extends StatelessWidget {
  final String image;
  final String title;

  _SliverAppBar({
    this.image,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var ratio = DeviceAspectRatio.of(context);
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.black,
      toolbarHeight: ratio.toolbarHeight,
      expandedHeight: ratio.longestArea * 580,
      collapsedHeight: ratio.toolbarHeight * 1.02,
      leading: TextButton(
        child: Icon(
          CupertinoIcons.arrow_left,
          size: ratio.icon2,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          title.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontFamily: 'Antonio',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        titlePadding: EdgeInsets.symmetric(vertical: 8.0),
        collapseMode: CollapseMode.pin,
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFF000000),
                Color(0x80000000),
                Color(0x00000000),
                Color(0x00000000),
                Color(0x00000000),
                Color(0x80000000),
                Color(0xCC000000),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(CupertinoIcons.share_up),
          padding: EdgeInsets.zero,
          iconSize: ratio.icon2,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _Body extends StatefulWidget {
  final Movie movie;
  _Body(this.movie);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  final client = MovieServiceClient(
    grpc.ClientChannel(
      "192.168.43.164",
      port: 9000,
      options: grpc.ChannelOptions(
        credentials: grpc.ChannelCredentials.insecure(),
      ),
    ),
  );

  grpc.ResponseFuture<MovieResponse> responseFuture;

  @override
  void initState() {
    super.initState();
    responseFuture = client.movie(MovieRequest(source: widget.movie.source));
  }

  @override
  void dispose() {
    super.dispose();
    responseFuture.cancel();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.movie.source);
    return FutureBuilder<MovieResponse>(
      future: responseFuture,
      builder: (context, snapshot) {
        var movieResponse = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return _Loader();
          default:
        }
        var movie = movieResponse.movie;
        return _Data(movie);
      },
    );
  }
}

class _Data extends StatelessWidget {
  final Movie movie;
  _Data(this.movie);
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return DefaultTabController(
      length: 2,
      child: SliverFillRemaining(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      backgroundColor: Colors.white,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      label: Text(movie.production),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      backgroundColor: Colors.white,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      label: Text(movie.language),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Chip(
                      backgroundColor: Color(0xFFE1032E),
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      label: Text("8.7"),
                      avatar: Icon(
                        CupertinoIcons.star_fill,
                        color: Colors.white,
                        size: 16.0,
                      ),
                      labelPadding: EdgeInsets.only(right: 4.0),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                movie.genres.join(" • "),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                child: Divider(
                  indent: 20.0,
                  endIndent: 20.0,
                  color: theme.accentColor,
                ),
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF000000),
                      Color(0x00000000),
                      Color(0xFF000000),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return ZoomPageTransitionsBuilder().buildTransitions(
                          null,
                          context,
                          animation,
                          secondaryAnimation,
                          Player(movie: movie),
                        );
                      },
                    ),
                  );
                },
                icon: Icon(CupertinoIcons.play_arrow_solid),
                label: Text("Regarder maintenant"),
              ),
            ),
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.only(
                top: 5.0,
                left: 16.0,
                right: 16.0,
              ),
              title: Text(
                movie.subtitle.toUpperCase(),
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              tabs: [
                Tab(text: 'SYNOPSIS'),
                Tab(text: 'VIDEO'),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TabBarView(
                  children: [
                    Container(
                      child: Text(movie.synopsis),
                    ),
                    Container(
                      child: Text("Video"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    child: _Loading(),
                    height: 30.0,
                    width: 70.0,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 200.0,
              height: 20.0,
              child: _Loading(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Divider(
              indent: 20.0,
              endIndent: 20.0,
              color: theme.accentColor,
            ),
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF000000),
                  Color(0x00000000),
                  Color(0xFF000000),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 200.0,
              height: 30.0,
              child: _Loading(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 100.0,
                height: 20.0,
                child: _Loading(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    child: _Loading(),
                    height: 20.0,
                    width: 70.0,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

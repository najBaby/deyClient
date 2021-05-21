import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'article.dart';
import 'widgets.dart';
import 'core/device.dart';
import 'service/movie.dart';
import 'service/service.dart';
import 'service/schema/movie.pb.dart';

class SearchArticlesScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var service = Service.of(context);
    var movieService = service.movieService;
    movieService.handle = SearchMovies("");
    return Scaffold(
      body: _Body(),
    );
  }
}

class _SliverAppBar extends StatefulWidget {
  final TextEditingController controller;

  _SliverAppBar({this.controller});

  @override
  __SliverAppBarState createState() => __SliverAppBarState();
}

class __SliverAppBarState extends State<_SliverAppBar> {
  MovieService movieService;
  TextEditingController get controller => widget.controller;

  void onSubmitted() {
    var state = movieService.value;
    if (state is MovieFailure) {
      var scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(SnackBar(
        content: Text(state.message),
        action: SnackBarAction(
          label: 'Réessayer',
          onPressed: () {
            movieService.handle = SearchMovies(controller.text);
          },
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var service = Service.of(context);
    movieService = service.movieService;
    movieService.addListener(onSubmitted);
  }

  @override
  void dispose() {
    super.dispose();
    movieService.removeListener(onSubmitted);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      titleSpacing: 8.0,
      toolbarHeight: 58.0,
      title: CupertinoSearchTextField(
        controller: controller,
        padding: EdgeInsets.all(8.0),
        style: TextStyle(color: Colors.white),
        onSubmitted: (query) {
          movieService.handle = SearchMovies(query);
        },
        placeholder: 'Rechercher',
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  MovieService movieService;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var service = Service.of(context);
    movieService = service.movieService;
  }

  Text text(String text, double size) {
    return Text(
      text.toUpperCase(),
      softWrap: false,
      overflow: TextOverflow.fade,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: size,
        fontFamily: 'Antonio',
        fontWeight: FontWeight.w500,
      ),
    );
  }

  void onTap(Movie movie) {
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
            MovieScaffold(
              movie: movie,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MovieState>(
      valueListenable: movieService,
      builder: (context, value, child) {
        SliverChildDelegate delegate = loadingMovies();
        ScrollPhysics physics = NeverScrollableScrollPhysics();

        if (value is MovieSuccess) {
          delegate = listMovies(value.movies);
          physics = AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          );
        }

        var device = Device.of(context);
        return CustomScrollView(
          physics: physics,
          slivers: [
            _SliverAppBar(
              controller: controller,
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: device.insets + 10.0,
                vertical: 5.0,
              ),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200.0,
                  crossAxisSpacing: 16.0,
                  childAspectRatio: 0.5,
                  mainAxisSpacing: 5.0,
                ),
                delegate: delegate,
              ),
            ),
          ],
        );
      },
    );
  }

  SliverChildDelegate listMovies(List<Movie> movies) {
    return SliverChildBuilderDelegate(
      (context, index) {
        var movie = movies[index];
        return MovieTile(
          image: movie.image,
          onTap: () => onTap(movie),
          title: text(movie.title, 20.0),
          subtitle: text(movie.subtitle, 16.0),
        );
      },
      childCount: movies.length,
    );
  }

  SliverChildDelegate loadingMovies() {
    var decoration = BoxDecoration(
      color: Colors.grey[800],
      borderRadius: BorderRadius.circular(2.0),
    );
    return SliverChildBuilderDelegate(
      (context, index) {
        return Column(
          children: [
            Expanded(
              child: Container(
                decoration: decoration,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Container(
                height: 20.0,
                decoration: decoration,
              ),
              subtitle: Container(
                height: 15.0,
                decoration: decoration,
              ),
            ),
          ],
        );
      },
      childCount: 20,
    );
  }
}

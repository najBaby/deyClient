import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'core/aspect.dart';
import 'article.dart';
import 'search.dart';
import 'settings.dart';
import 'test.dart';

class HomeScaffoldd extends StatefulWidget {
  @override
  _HomeScaffolddState createState() => _HomeScaffolddState();
}

class _HomeScaffolddState extends State<HomeScaffoldd> {
  List<Widget> children;
  int currentIndex = 0;

  void onTap(int value) {
    if (currentIndex != value)
      setState(() {
        currentIndex = value;
      });
  }

  @override
  void initState() {
    super.initState();
    children = [
      ListArticlesScaffold(),
      SearchArticlesScaffold(),
      TestScaffold(),
      SettingsScaffold(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: children.elementAt(currentIndex),
      bottomNavigationBar: _BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}

class ListArticlesScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var ratio = DeviceAspectRatio.of(context);
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        headerSliverBuilder: headerSliverBuilder,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            categoryBuilder(context, 100),
            categoryBuilder(context, 250),
            categoryBuilder(context, 250),
          ],
        ),
      ),
    );
  }

  Widget categoryBuilder(BuildContext context, double height) {
    var theme = Theme.of(context);
    var ratio = DeviceAspectRatio.of(context);
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 10),
      sliver: SliverToBoxAdapter(
        child: Column(
          children: [
            ListTile(
              dense: true,
              visualDensity: VisualDensity(
                horizontal: -4.0,
                vertical: -4.0,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              title: Text(
                "SERIES ET FILMS",
                style: TextStyle(
                  color: theme.accentColor,
                ),
              ),
            ),
            SizedBox.fromSize(
              size: Size.fromHeight(height),
              child: ListView.separated(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: 20,
                padding: EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemBuilder: (context, index) {
                  return GridTile(
                    child: SizedBox(
                      width: 160,
                      child: Material(
                        color: Colors.transparent,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: FadeInImage(
                          placeholder: AssetImage(
                            "images/spices-shop.jpeg",
                          ),
                          image: AssetImage(
                            "images/spices-shop.jpeg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> headerSliverBuilder(BuildContext context, bool innerScrolled) {
    var theme = Theme.of(context);
    var ratio = DeviceAspectRatio.of(context);
    return [
      SliverAppBar(
        toolbarHeight: ratio.toolbarHeight,
        title: Text(
          "Dey",
          style: TextStyle(
            fontSize: ratio.heading5,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            iconSize: ratio.icon2,
            icon: Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
          IconButton(
            iconSize: ratio.icon1,
            icon: Icon(CupertinoIcons.bars),
            onPressed: () {},
          ),
        ],
      ),
    ];
  }
}

class HomeScaffold extends StatefulWidget {
  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int currrentIndex = 0;
  bool status = true;
  @override
  void initState() {
    super.initState();
  }

  bool onScroll(ScrollNotification notification) {
    if (notification is UserScrollNotification)
      switch (notification.direction) {
        case ScrollDirection.forward:
          if (!status) {
            setState(() {
              status = true;
            });
          }
          break;
        case ScrollDirection.reverse:
          if (!notification.metrics.atEdge ||
              !notification.metrics.outOfRange) {
            if (status) {
              setState(() {
                status = false;
              });
            }
          }
          break;
        default:
      }
    return true;
  }

  void onTap(int value) {
    if (currrentIndex != value)
      setState(() {
        currrentIndex = value;
      });
  }

  ThemeData theme;
  DeviceAspectRatio ratio;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
    ratio = DeviceAspectRatio.of(context);
  }

  // var size = mediaQuery.size;

  // var area = size.longestSide + size.shortestSide / 2;
  // var movie = (300 * size.longestSide) / area;
  // var text = (35 * size.longestSide) / area;
  // var icon = (30 * size.longestSide) / area;
  // var bar = (70 * size.longestSide) / area;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            toolbarHeight: ratio.toolbarHeight,
            leading: IconButton(
              iconSize: ratio.icon1,
              icon: Icon(CupertinoIcons.bars),
              onPressed: () {},
            ),
            bottom: PreferredSize(
              child: Container(),
              preferredSize: Size.fromHeight(ratio.toolbarHeight),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(16),
              title: Text(
                "FILMS ET SERIES",
                style: TextStyle(
                  color: theme.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: ratio.heading4,
                ),
              ),
            ),
            actions: [
              IconButton(
                iconSize: ratio.icon2,
                icon: Icon(CupertinoIcons.search),
                onPressed: () {},
              )
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieScaffold(
                            tag: "film $index",
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: "film $index",
                      child: GridTile(
                        child: Material(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: FadeInImage(
                            placeholder: AssetImage(
                              "images/spices-shop.jpeg",
                            ),
                            image: AssetImage(
                              "images/spices-shop.jpeg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: 6,
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: ratio.longestArea * 400,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: AnimatedSwitcher(
        reverseDuration: Duration(milliseconds: 200),
        duration: Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0.0, 1.0),
              end: Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          );
        },
        child: status
            ? _BottomNavigationBar(
                currentIndex: currrentIndex,
                onTap: onTap,
              )
            : SizedBox.shrink(),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  _BottomNavigationBar({
    Key key,
    this.onTap,
    this.currentIndex,
  }) : super(key: key);
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var ratio = DeviceAspectRatio.of(context);

    return BottomAppBar(
      child: SizedBox.fromSize(
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: 'ACCUEIL',
              activeIcon: Icon(CupertinoIcons.house_alt_fill),
              icon: Icon(CupertinoIcons.house_alt),
            ),
            BottomNavigationBarItem(
              label: 'REHCERCHE',
              icon: Icon(CupertinoIcons.search),
              activeIcon: Icon(CupertinoIcons.search),
            ),
            BottomNavigationBarItem(
              label: 'PAIEMENTS',
              icon: Icon(CupertinoIcons.creditcard),
              activeIcon: Icon(CupertinoIcons.creditcard_fill),
            ),
            BottomNavigationBarItem(
              label: 'PARAMETRES',
              icon: Icon(CupertinoIcons.gear),
              activeIcon: Icon(CupertinoIcons.gear_solid),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedLabelStyle: TextStyle(
            fontSize: ratio.subtitle2,
          ),
          unselectedItemColor: Color(0xFF585B5E),
          currentIndex: currentIndex,
          iconSize: ratio.icon2,
          elevation: 0.0,
          onTap: onTap,
        ),
        size: Size.fromHeight(
          ratio.toolbarHeight,
        ),
      ),
      color: Colors.transparent,
      elevation: 0.0,
    );
  }
}

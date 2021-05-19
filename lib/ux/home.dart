import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScaffold extends StatefulWidget {
  final int currentIndex;

  const HomeScaffold({
    this.currentIndex = 0,
  });

  @override
  _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;

    super.initState();
  }

  void _onTap(int value) => setState(() => _currentIndex = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    Key key,
    this.onTap,
    this.currentIndex,
  }) : super(key: key);

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}

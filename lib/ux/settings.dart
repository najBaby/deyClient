import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: _AppBar(height: 58.0),
      body: _Body(),
    );
  }
}

class _AppBar extends PreferredSize {
  _AppBar({
    this.height,
  });

  final double height;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: TextButton(
        child: Icon(CupertinoIcons.arrow_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text("PARAMETRES"),
      toolbarHeight: preferredSize.height,
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var contentPadding = EdgeInsets.only(
      left: 10.0,
      right: 16.0,
    );
    return ListView(
      physics: BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: EdgeInsets.symmetric(),
      children: [
        ListTile(
          title: Text(
            "LES DONNEES PERSONNELLES",
            style: TextStyle(),
          ),
        ),
        ListTile(
          contentPadding: contentPadding,
          leading: SizedBox(
            child: Icon(CupertinoIcons.paintbrush),
          ),
          onTap: () {},
          title: Text(
            "Compte",
            style: TextStyle(),
          ),
          subtitle: Text(
            "Modifier votre profil, vos favoris de films",
            style: TextStyle(),
          ),
        ),
        ListTile(
          contentPadding: contentPadding,
          leading: SizedBox(
            child: Icon(CupertinoIcons.paintbrush),
          ),
          onTap: () {},
          title: Text(
            "Compte",
            style: TextStyle(),
          ),
          subtitle: Text(
            "Modifier votre profil, vos favoris de films",
            style: TextStyle(),
          ),
        ),
        ListTile(
          contentPadding: contentPadding,
          leading: SizedBox(
            child: Icon(CupertinoIcons.paintbrush),
          ),
          onTap: () {},
          title: Text(
            "Compte",
            style: TextStyle(),
          ),
          subtitle: Text(
            "Modifier votre profil, vos favoris de films",
            style: TextStyle(),
          ),
        ),
        ListTile(
          contentPadding: contentPadding,
          leading: SizedBox(
            child: Icon(CupertinoIcons.paintbrush),
          ),
          onTap: () {},
          title: Text(
            "Compte",
            style: TextStyle(),
          ),
          subtitle: Text(
            "Modifier votre profil, vos favoris de films",
            style: TextStyle(),
          ),
        ),
        ListTile(
          title: Text(
            "LES INFOS DE L'APPLICATION",
            style: TextStyle(),
          ),
        ),
        ListTile(
          contentPadding: contentPadding,
          leading: SizedBox(
            child: Icon(CupertinoIcons.paintbrush),
          ),
          onTap: () {},
          title: Text(
            "Compte",
            style: TextStyle(),
          ),
          subtitle: Text(
            "Modifier votre profil, vos favoris de films",
            style: TextStyle(),
          ),
        ),
        ListTile(
          contentPadding: contentPadding,
          leading: SizedBox(
            child: Icon(CupertinoIcons.paintbrush),
          ),
          onTap: () {},
          title: Text(
            "Compte",
            style: TextStyle(),
          ),
          subtitle: Text(
            "Modifier votre profil, vos favoris de films",
            style: TextStyle(),
          ),
        ),
      ],
    );
  }
}

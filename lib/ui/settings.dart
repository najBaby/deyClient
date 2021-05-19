import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'core/aspect.dart';
import 'widgets.dart';

class SettingsScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var ratio = DeviceAspectRatio.of(context);
    var contentPadding = EdgeInsets.only(
      left: 10.0,
      right: 16.0,
      top: ratio.longestArea * 10,
      bottom: ratio.longestArea * 10,
    );
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: ratio.toolbarHeight,
        title: Text(
          "Paramètres",
          style: TextStyle(
            fontSize: ratio.heading6,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: EdgeInsets.symmetric(
          vertical: ratio.longestArea * 10,
        ),
        children: [
          ListItem(
            title: Text(
              "LES DONNEES PERSONNELLES",
              style: TextStyle(
                color: theme.accentColor,
                fontSize: ratio.subtitle1,
              ),
            ),
          ),
          ListItem(
            contentPadding: contentPadding,
            leading: SizedBox(
              child: Icon(CupertinoIcons.paintbrush),
              width: ratio.toolbarHeight,
            ),
            onTap: () {},
            title: Text(
              "Compte",
              style: TextStyle(
                fontSize: ratio.heading6 * 0.82,
              ),
            ),
            subtitle: Text(
              "Modifier votre profil, vos favoris de films",
              style: TextStyle(
                fontSize: ratio.subtitle1,
              ),
            ),
          ),
          ListItem(
            contentPadding: contentPadding,
            leading: SizedBox(
              child: Icon(CupertinoIcons.paintbrush),
              width: ratio.toolbarHeight,
            ),
            onTap: () {},
            title: Text(
              "Compte",
              style: TextStyle(
                fontSize: ratio.heading6 * 0.82,
              ),
            ),
            subtitle: Text(
              "Modifier votre profil, vos favoris de films",
              style: TextStyle(
                fontSize: ratio.subtitle1,
              ),
            ),
          ),
          ListItem(
            contentPadding: contentPadding,
            leading: SizedBox(
              child: Icon(CupertinoIcons.paintbrush),
              width: ratio.toolbarHeight,
            ),
            onTap: () {},
            title: Text(
              "Compte",
              style: TextStyle(
                fontSize: ratio.heading6 * 0.82,
              ),
            ),
            subtitle: Text(
              "Modifier votre profil, vos favoris de films",
              style: TextStyle(
                fontSize: ratio.subtitle1,
              ),
            ),
          ),
          ListItem(
            contentPadding: contentPadding,
            leading: SizedBox(
              child: Icon(CupertinoIcons.paintbrush),
              width: ratio.toolbarHeight,
            ),
            onTap: () {},
            title: Text(
              "Compte",
              style: TextStyle(
                fontSize: ratio.heading6 * 0.82,
              ),
            ),
            subtitle: Text(
              "Modifier votre profil, vos favoris de films",
              style: TextStyle(
                fontSize: ratio.subtitle1,
              ),
            ),
          ),
          ListItem(
            title: Text(
              "LES INFOS DE L'APPLICATION",
              style: TextStyle(
                color: theme.accentColor,
                fontSize: ratio.subtitle1,
              ),
            ),
          ),
          ListItem(
            contentPadding: contentPadding,
            leading: SizedBox(
              child: Icon(CupertinoIcons.paintbrush),
              width: ratio.toolbarHeight,
            ),
            onTap: () {},
            title: Text(
              "Compte",
              style: TextStyle(
                fontSize: ratio.heading6 * 0.82,
              ),
            ),
            subtitle: Text(
              "Modifier votre profil, vos favoris de films",
              style: TextStyle(
                fontSize: ratio.subtitle1,
              ),
            ),
          ),
          ListItem(
            contentPadding: contentPadding,
            leading: SizedBox(
              child: Icon(CupertinoIcons.paintbrush),
              width: ratio.toolbarHeight,
            ),
            onTap: () {},
            title: Text(
              "Compte",
              style: TextStyle(
                fontSize: ratio.heading6 * 0.82,
              ),
            ),
            subtitle: Text(
              "Modifier votre profil, vos favoris de films",
              style: TextStyle(
                fontSize: ratio.subtitle1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

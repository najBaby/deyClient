import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var media = MediaQuery.of(context);
    var size = media.size;
    var decoration = InputDecoration();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          heightFactor: 2,
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Bienvenue",
                    style: TextStyle(
                      fontSize: size.shortestSide * 0.07,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      decoration: decoration.copyWith(
                        prefixIcon: Icon(CupertinoIcons.mail),
                        hintText: "Entrez votre email",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      decoration: decoration.copyWith(
                        prefixIcon: Icon(CupertinoIcons.lock),
                        hintText: "Entrez votre mot de passe",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.accentColor,
                        shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text("Je me connecte"),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FractionallySizedBox(
          widthFactor: 0.85,
          child: Form(
            child: Column(
              children: [
                TextFormField(),
                TextFormField(),
                TextFormField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

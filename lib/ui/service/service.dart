import 'package:flutter/widgets.dart';
import 'package:grpc/grpc.dart';

import 'movie.dart';

class Service extends InheritedWidget {
  Service({
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  static final client = ClientChannel(
    "206.189.58.26",
    port: 443,
    options: ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  final movieService = MovieService(client: client);

  @override
  bool updateShouldNotify(_) => true;
  static Service of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Service>();
}

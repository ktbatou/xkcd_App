import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/comics_feed/presentation/pages/comics_home.dart';
import 'package:xkcd_app/comics_feed/presentation/provider/Comic_Id_provider.dart';
import 'package:xkcd_app/comics_feed/presentation/provider/Comic_provider.dart';
import 'package:xkcd_app/core/provider/NetworkInfoProvider.dart';
import 'package:xkcd_app/core/provider/favorite_provider.dart';
import 'injections.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setup();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        create: (context) => di.serviceLocator<ComicIdProvider>()),
    ChangeNotifierProvider(
        create: (context) => di.serviceLocator<ComicProvider>()),
    ChangeNotifierProvider(
        create: (context) => di.serviceLocator<NetworkInfoProvider>()),
    ChangeNotifierProvider(
        create: (context) => di.serviceLocator<FavoriteProvider>()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ComicsHome());
  }
}

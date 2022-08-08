import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:xkcd_app/features/comics_feed/presentation/pages/comics_home.dart';
import 'package:xkcd_app/features/comics_feed/presentation/provider/Comic_Id_provider.dart';
import 'package:xkcd_app/features/favorite_comics/presentation/pages/favorite_comics_page.dart';
import 'package:xkcd_app/features/search/presentation/pages/search_comic_page.dart';
import '../provider/NetworkInfoProvider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _selectedIndex = 0;
  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _checker("first", false);
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      bool isDeviceConnected = true;
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      _checker("second", isDeviceConnected);
    });
  }

  _checker(String section, bool isDeviceConnected) async {
    if (section == "first") {
      await Provider.of<NetworkInfoProvider>(context, listen: false)
          .checkNetwork();
      await Provider.of<ComicIdProvider>(context, listen: false).checkComicId();
    } else {
      Provider.of<NetworkInfoProvider>(context, listen: false)
          .setNetworkAvailability(isDeviceConnected);
      await Provider.of<ComicIdProvider>(context, listen: false).checkComicId();
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    ComicsHome(),
    FavoriteComic(),
    SearchComic(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: const Text(
          "xkcd Comics",
          style: TextStyle(
              fontFamily: 'LSANS',
              fontWeight: FontWeight.w800,
              color: Colors.black87,
              fontSize: 16),
        ),
        backgroundColor: const Color(0xffF5F5F5),
      ),
      backgroundColor: const Color(0xffF5F5F5),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffF5F5F5),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey.shade100,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: 'Favorite',
            backgroundColor: Colors.grey.shade100,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.grey.shade100,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey.shade600, //Color(0xff96A8C8),
        onTap: _onItemTapped,
      ),
    );
    ;
  }
}

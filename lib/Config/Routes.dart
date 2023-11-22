import 'package:flutter/material.dart';
import 'package:movieapp/Features/HomeLayout.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/BrowseCategories.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/HomeScreen.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/MovieByCategory.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/MovieDetails.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/SearchScreen.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/WatchList.dart';


class RoutesName {
  static const String homeLayout = "/";
  static const String homeScreen = "homeScreen";
  static const String searchScreen = "SearchScreen";
  static const String browse = "browse";
  static const String wathList = "watchlist";
  static const String movieDetails = "details";
  static const String moviecategory = "moviecategory";
}

class AppRoute {
  static Route onGenerate(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.homeLayout:
        return MaterialPageRoute(
          builder: (context) => HomeLayout(),
        );
      case RoutesName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case RoutesName.searchScreen:
        return MaterialPageRoute(
          builder: (context) => SearchScreen(),
        );
      case RoutesName.browse:
        return MaterialPageRoute(
          builder: (context) => BrowseCategories(),
        );
      case RoutesName.wathList:
        return MaterialPageRoute(
          builder: (context) => WatchList(),
          
        );
      case RoutesName.movieDetails:
        return MaterialPageRoute(
          builder: (context) => MovieDetails(),

        );
      case RoutesName.moviecategory:
        return MaterialPageRoute(
          builder: (context) => MovieByCategory(),

        );
        

      default:
        return MaterialPageRoute(
          builder: (context) => unDefinedRoute(),
        );
    }
  }

  static Widget unDefinedRoute() {
    return Scaffold(
      appBar: AppBar(title: Text("UnDefine Route")),
      body: Center(child: Text("Route not Found")),
    );
  }
}

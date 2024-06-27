import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';
import 'package:movieapp/Core/Utils/AppStrings.dart';

import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/BrowseCategories.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/HomeScreen.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/SearchScreen.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/WatchList.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> tabs = [
    HomeScreen(),
    SearchScreen(),
    BrowseCategories(),
    WatchList()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularMoviesBloc(),
      child: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: AppColors.primaryblack,
                      icon: Icon(Icons.home),
                      label: AppStrings.home),
                  BottomNavigationBarItem(
                      backgroundColor: AppColors.primaryblack,
                      icon: Icon(Icons.search),
                      label: AppStrings.search),
                  BottomNavigationBarItem(
                      backgroundColor: AppColors.primaryblack,
                      icon: Icon(Icons.movie),
                      label: AppStrings.browse),
                  BottomNavigationBarItem(
                      backgroundColor: AppColors.primaryblack,
                      icon: Icon(Icons.collections_bookmark_rounded),
                      label: AppStrings.watchlist),
                ],
                currentIndex: index,
                onTap: (value) {
                  index = value;
                  setState(() {});
                },
                selectedItemColor: AppColors.whitecolor,
                unselectedItemColor: AppColors.unselectcolor,
                elevation: 3,
              ),
              body: tabs[index],
            ),
          );
        },
      ),
    );
  }
}

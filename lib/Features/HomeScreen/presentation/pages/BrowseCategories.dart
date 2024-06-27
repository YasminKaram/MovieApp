import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Config/Routes.dart';
import 'package:movieapp/Core/Utils/AppStyles.dart';
import 'package:movieapp/Features/HomeScreen/data/models/CategoryModel.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/CategoryEntity.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';
import 'package:movieapp/Features/HomeScreen/presentation/pages/MovieByCategory.dart';

class BrowseCategories extends StatelessWidget {

  List<String>image=[
    "assets/images/action.jpg",
    "assets/images/adv.jpeg",
    "assets/images/animation.jpeg",
    "assets/images/comedy.jpg",
    "assets/images/crimejpeg.jpeg",
    "assets/images/doc.jpeg",
    "assets/images/drama.jpeg",
    "assets/images/family.jpeg",
    "assets/images/fan.jpeg",
    "assets/images/history.jpeg",
    "assets/images/horror.jpeg",
    "assets/images/music.jpeg",
    "assets/images/mystry.jpeg",
    "assets/images/romance.jpeg",
    "assets/images/science.jpeg",
    "assets/images/Tv.jpeg",
    "assets/images/trie.jpeg",
    "assets/images/war.jpeg",
    "assets/images/westren.jpeg"

  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularMoviesBloc()..add(GetCategory()),
      child: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Browse Category",style: AppStyles.headLine.copyWith(fontSize: 18,fontWeight: FontWeight.bold),),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 0.1,
                        crossAxisSpacing: 20),
                    cacheExtent: 2,
                    itemBuilder: (context, index) {
                      return InkWell (
                        onTap: ()async{

                          PopularMoviesBloc.categoryid=await PopularMoviesBloc.categoryList[index].id;
                          PopularMoviesBloc.get(context).add(GetMoviesCategory());
                          Navigator.pushNamed(context, RoutesName.moviecategory);

                        },
                        child: Container(
                          height: 100.h,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(image[index],
                                  fit: BoxFit.fill, width: 250.w, height: 150.h),
                              Text(PopularMoviesBloc.categoryList[index].name ?? "",
                                  style: AppStyles.headLine.copyWith(fontSize: 20,fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: PopularMoviesBloc.categoryList.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

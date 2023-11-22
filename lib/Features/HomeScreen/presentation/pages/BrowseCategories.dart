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
  const BrowseCategories({super.key});

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
                              Image.asset("assets/images/category.png",
                                  fit: BoxFit.fill, width: 250.w, height: 150.h),
                              Text(PopularMoviesBloc.categoryList[index].name ?? "",
                                  style: AppStyles.headLine.copyWith(fontSize: 18)),
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

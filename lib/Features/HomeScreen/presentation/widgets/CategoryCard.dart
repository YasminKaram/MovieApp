import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';
import 'package:movieapp/Core/Utils/AppStyles.dart';
import 'package:movieapp/Core/Utils/Constants.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';

class CategoryMovieCard extends StatelessWidget {
  String? path;
  bool? select;
  String? moviename;
  num? rate;
  String? date;
  int? index;

  CategoryMovieCard(
      this.path, this.select, this.moviename, this.rate, this.index,this.date);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 500.h,
        width: 400.w,
        color: AppColors.itemmovie,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              //alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: Image.network("${Constants.imagesurl}${path ?? ""}",fit: BoxFit.fill,height: 120.h,width: 250.w,),
                ),

                Positioned(
                  right: 166.w,
                  bottom: 80.h,
                  child:  IconButton(
                    onPressed: () {
                      PopularMoviesBloc.index = index;
                      PopularMoviesBloc.get(context)
                          .add(ClickMarkCategoryEvent());
                    },
                    icon: PopularMoviesBloc
                        .moviescategory[index!]
                        .select ??
                        false
                        ? Icon(
                      size: 45.r,
                      Icons.bookmark_added,color: AppColors.selectcolor,)
                        : Icon(
                        size: 45.r,
                        Icons.bookmark_add_rounded,color: AppColors.iconadd),
                  )
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric( horizontal: 10.0.w,vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.selectcolor,
                      ),
                      Text(
                        "$rate",
                        style: AppStyles.movieName,
                      ),
                    ],
                  ),
                  Text(moviename!,
                      style: AppStyles.movieName.copyWith(fontSize: 12),
                      overflow: TextOverflow.clip,
                      maxLines: 1),
                  Text(date!, style: AppStyles.date.copyWith(fontSize: 10))
                ],
              ),
            ),
          ],
        ),
      ),
    );;
  }
}

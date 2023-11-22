import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';
import 'package:movieapp/Core/Utils/AppStyles.dart';
import 'package:movieapp/Core/Utils/Constants.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';

class CardMovie extends StatelessWidget {
  String? path;
  bool? select;
  String? moviename;
  num? rate;
  String? date;
  int? index;
  bool details;

  CardMovie(
      this.path, this.select, this.moviename, this.rate, this.index, this.date,this.details);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        height: 180.h,
        width: 97.w,
        color: AppColors.itemmovie,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              //alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: Image.network("${Constants.imagesurl}${path ?? ""}",height: 130.h,width: 95.w,fit: BoxFit.fill),
                ),
                Positioned(
                  right: 62.w,
                  bottom: 90.h,
                  child: IconButton(
                    onPressed: () {
                      PopularMoviesBloc.index = index;
                      details ==false?
                      PopularMoviesBloc.get(context)
                          .add(ClickMarkRecomendedMovie()):
                      PopularMoviesBloc.get(context)
                          .add(ClickMarkmoreLikeEvent());
                    },
                    icon: select == false
                        ? Icon(
                            size: 42.r,
                            Icons.bookmark_add_rounded,
                            color: AppColors.iconadd,
                          )
                        : Icon(
                            size: 42.r,
                            Icons.bookmark_added,
                            color: AppColors.selectcolor,
                          ),
                  ),
                )
              ],
            ),
            SizedBox(height:10.h ,),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 2.0.w),
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
                  Container(
                    width: 80,
                    child: Text(moviename!,
                        style: AppStyles.movieName.copyWith(fontSize: 10.sp),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2),
                  ),
                  Text(date!, style: AppStyles.date)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

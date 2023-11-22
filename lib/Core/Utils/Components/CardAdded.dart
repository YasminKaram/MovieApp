import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';
import 'package:movieapp/Core/Utils/AppStyles.dart';
import 'package:movieapp/Core/Utils/Constants.dart';
import 'package:movieapp/Features/HomeScreen/data/data_sources/Local/MoviesLocalDsImp.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';

class CardAdded extends StatelessWidget {
  List<ResultsEntity> movies = [];
  int index;

  CardAdded(this.movies, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: AppColors.itemmovie,
        height: 110.h,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    //alignment: Alignment.topLeft,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Image.network(
                            height: 110.h,
                            fit: BoxFit.fill,
                            width: 100.w,
                            "${Constants.imagesurl}${movies[index].posterPath ?? ""}"),
                      ),
                      Positioned(
                          right: 65.w,
                          bottom: 70.h,
                          child: IconButton(
                            onPressed: () {
                              MoviesLocalDsImp.deletemovie(movies[index].movieId!);
                            },
                            icon: Icon(size: 25, Icons.bookmark_added,color: AppColors.selectcolor,),

                          )),
                    ],
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text("${movies[index].title}",
                          style: AppStyles.movieName.copyWith(fontSize: 15.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                    Text("${movies[index].releaseDate}",
                        style: AppStyles.date.copyWith(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1),
                    Container(
                      width: 200,
                      child: Text(
                        "${movies[index].originalTitle}",
                        style: AppStyles.date.copyWith(fontSize: 12.sp),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
    );
  }
}

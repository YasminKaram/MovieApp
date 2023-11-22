import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Config/Routes.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';
import 'package:movieapp/Core/Utils/AppStyles.dart';
import 'package:movieapp/Core/Utils/Components/CardofMovie.dart';
import 'package:movieapp/Core/Utils/Constants.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/PopularMovies.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/PopularMovies.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MovieDetails extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    //var args=ModalRoute.of(context)?.settings.arguments as Re

    return BlocProvider(
      create: (context) =>
      PopularMoviesBloc()
        ..add(DetailsMovie())..add(GetMoreLike()),
      child: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
  listener: (context, state) {
    if (state.screenStatus == ScreenStatus.detailsloading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SizedBox(
          width: 200.0,
          height: 100.0,
          child: Shimmer.fromColors(
            baseColor: AppColors.iconadd,
            highlightColor: AppColors.darkgray,
            child:Container(color: Colors.white,)
          ),
        ),
      );
    }
    if (state.screenStatus == ScreenStatus.detailsSuccess) {
      Navigator.pop(context);
    }
  },
  builder: (context, state) {
    return Scaffold(
        appBar: AppBar(backgroundColor: AppColors.iconadd,
          title: Text(PopularMoviesBloc.entity?.title ?? "",
              style: AppStyles.headLine.copyWith(fontSize: 18.sp)),),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    height: 250.h,
                    width: 412.w,
                    child: Image.network(
                        fit: BoxFit.fill,
                        "${Constants.imagesurl}${PopularMoviesBloc.entity
                            ?.posterPath ?? ""}")),
                Icon(Icons.play_circle,
                    size: 70, color: AppColors.whitecolor)
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Text(PopularMoviesBloc.entity?.title ?? "",
                  style: AppStyles.headLine.copyWith(fontSize: 18.sp)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
              child: Text(PopularMoviesBloc.entity?.releaseDate ?? "",
                  style: AppStyles.date.copyWith(fontSize: 12.sp)),
            ),

            Row(children: [
              Expanded(
                child: Column(
                  children: [
                    Stack(
                      //alignment: Alignment.topLeft,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(5.r),
                            child: Image.network(
                              height: 230.h,
                                width: 180.w,
                                "${Constants.imagesurl}${PopularMoviesBloc.entity
                                    ?.posterPath ?? ""}"),
                          ),
                        ),
                        Positioned(
                            right: 125.w,
                            bottom: 190.h,
                            child: IconButton(
                              onPressed: () {
                                //PopularMoviesBloc.index = index;
                                PopularMoviesBloc.get(context)
                                    .add(ClickMarkdetailsmovieEvent());
                              },
                              icon: PopularMoviesBloc
                                  .entity
                                  ?.select ??
                                  false
                                  ? Icon(
                                size: 50.r,
                                Icons.bookmark_added,
                                color: AppColors.selectcolor,)
                                  : Icon(
                                  size: 50.r,
                                  Icons.bookmark_add_rounded,
                                  color: AppColors.iconadd),
                            ))
                      ],
                    )

                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 150,
                      child: Text(
                          PopularMoviesBloc.entity?.overview ?? "", maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.movieName.copyWith(fontSize: 14.sp)),
                    ),
                    Row(children: [
                      Icon(Icons.star, color: AppColors.selectcolor,),
                      Text("${PopularMoviesBloc.entity?.voteAverage}",
                          style: AppStyles.headLine),

                    ],)

                  ],
                ),
              )
            ],),
            Container(
              height: 250.h,
              child: Expanded(
                child: ListView.builder(itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.symmetric(
                        vertical: 3.0.h, horizontal: 3.0.w),
                    child: InkWell(
                      onTap: (){
                        PopularMoviesBloc.id =PopularMoviesBloc
                            .moreLikeMovie[index].id;
                        PopularMoviesBloc.idmoreLike =PopularMoviesBloc
                            .moreLikeMovie[index].id;
                        PopularMoviesBloc.get(context)
                            .add(DetailsMovie());
                        PopularMoviesBloc.get(context)
                            .add(GetMoreLike());

                        Navigator.pushNamed(
                            context, RoutesName.movieDetails);
                      },
                      child: CardMovie(
                          PopularMoviesBloc.moreLikeMovie[index].posterPath,
                          PopularMoviesBloc.moreLikeMovie[index].select??false,
                          PopularMoviesBloc.moreLikeMovie[index].title,
                          PopularMoviesBloc.moreLikeMovie[index].voteAverage,
                          index,
                          PopularMoviesBloc.moreLikeMovie[index].releaseDate,
                          true),
                    ),
                  );
                },itemCount: PopularMoviesBloc.moreLikeMovie.length,scrollDirection: Axis.horizontal),

              ),
            )


          ]),
        ),

      );
  },
),
    );
  }
}

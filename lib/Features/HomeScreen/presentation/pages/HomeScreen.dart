import 'package:carousel_slider/carousel_slider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Config/Routes.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';
import 'package:movieapp/Core/Utils/AppStrings.dart';
import 'package:movieapp/Core/Utils/AppStyles.dart';
import 'package:movieapp/Core/Utils/Components/CardofMovie.dart';
import 'package:movieapp/Core/Utils/Constants.dart';
import 'package:movieapp/Features/HomeScreen/data/data_sources/Local/MoviesLocalDsImp.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => PopularMoviesBloc()
          ..add(GetRealeseEvent())
          ..add(GetPopularEvent())
          ..add(GetRecomendedEvent()),

        child: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
          listener: (context, state) {
            if (state.screenStatus == ScreenStatus.popularloading ||
                state.screenStatus == ScreenStatus.realeseloading ||
                state.screenStatus == ScreenStatus.recomendedloading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Center(
                      child: CircularProgressIndicator(
                    color: AppColors.selectcolor,
                  )),
                ),
              );
            }
            if (state.screenStatus == ScreenStatus.popularSuccess ||
                state.screenStatus == ScreenStatus.recomendedSuccess ||
                state.screenStatus == ScreenStatus.realeseSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CarouselSlider(
                      items: PopularMoviesBloc.moviesPopular.map((e) {
                        return InkWell(
                          onTap: (){
                            PopularMoviesBloc.id =e.id;
                            PopularMoviesBloc.idmoreLike =e.id;
                            PopularMoviesBloc.get(context)
                                .add(DetailsMovie());
                            PopularMoviesBloc.get(context)
                                .add(GetMoreLike());

                            Navigator.pushNamed(
                                context, RoutesName.movieDetails);
                          },
                          child: Container(
                            height: 500.h,
                            color: Colors.transparent,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                          height: 250.h,
                                          width: 412.w,
                                          child: Image.network(
                                              fit: BoxFit.fill,
                                              "${Constants.imagesurl}${e.posterPath ?? ""}")),
                                      Icon(Icons.play_circle,
                                          size: 70, color: AppColors.whitecolor)
                                    ],
                                  ),
                                  Container(
                                    width: 450.w,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("${e.title}",
                                          maxLines: 1,
                                          style: AppStyles.movieName.copyWith(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w300),overflow: TextOverflow.ellipsis,),
                                    ),
                                  ),
                                  Text("${e.releaseDate}",
                                      style: AppStyles.movieName.copyWith(
                                          color: AppColors.datecolor,
                                          fontSize: 12.sp))
                                ]),
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 300.h,
                        aspectRatio: 3 / 2,
                        viewportFraction: 1.2,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
                        enlargeCenterPage: true,
                        enlargeFactor: 0,
                        //onPageChanged: callbackFunction,
                        scrollDirection: Axis.horizontal,
                      )),
                  Container(
                    color: AppColors.iconadd,
                    height: 187.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppStrings.newReleases,
                            style: AppStyles.headLine,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: ()  {

                                  PopularMoviesBloc.id =PopularMoviesBloc
                                      .moviesRealese[index].id;
                                  PopularMoviesBloc.idmoreLike =PopularMoviesBloc
                                      .moviesRealese[index].id;
                                  PopularMoviesBloc.get(context)
                                      .add(DetailsMovie());
                                  PopularMoviesBloc.get(context)
                                      .add(GetMoreLike());

                                  Navigator.pushNamed(
                                      context, RoutesName.movieDetails);
                                },
                                child: Stack(
                                  //alignment: Alignment.topLeft,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        child: Image.network(
                                            "${Constants.imagesurl}${PopularMoviesBloc.moviesRealese[index].posterPath ?? ""}"),
                                      ),
                                    ),
                                    Positioned(
                                        right: 61.w,
                                        bottom: 108.h,
                                        child: IconButton(
                                          onPressed: () {
                                            PopularMoviesBloc.index = index;
                                            PopularMoviesBloc.get(context)
                                                .add(ClickMarkEvent());
                                          },
                                          icon: PopularMoviesBloc
                                                      .moviesRealese[index]
                                                      .select ??
                                                  false
                                              ? Icon(
                                                  size: 42.r,
                                                  Icons.bookmark_added,color: AppColors.selectcolor,)
                                              : Icon(
                                                  size: 42.r,
                                                  Icons.bookmark_add_rounded,color: AppColors.unselectcolor),
                                        ))
                                  ],
                                ),
                              );
                            },
                            itemCount: PopularMoviesBloc.moviesRealese.length,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    color: AppColors.iconadd,
                    height: 280.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0.h, horizontal: 8.0.w),
                          child: Text(
                            AppStrings.recomended,
                            style: AppStyles.headLine,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  PopularMoviesBloc.id =PopularMoviesBloc
                                      .moviesRecomended[index].id;
                                  PopularMoviesBloc.idmoreLike =PopularMoviesBloc
                                      .moviesRecomended[index].id;
                                  PopularMoviesBloc.get(context)
                                      .add(DetailsMovie());
                                  PopularMoviesBloc.get(context)
                                      .add(GetMoreLike());

                                  Navigator.pushNamed(
                                      context, RoutesName.movieDetails);
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3.0.h, horizontal: 3.0.w),
                                  child: CardMovie(
                                      PopularMoviesBloc
                                          .moviesRecomended[index].posterPath,
                                      PopularMoviesBloc
                                              .moviesRecomended[index].select ??
                                          false,
                                      PopularMoviesBloc
                                          .moviesRecomended[index].originalTitle,
                                      PopularMoviesBloc
                                          .moviesRecomended[index].voteAverage,
                                      index,
                                      PopularMoviesBloc
                                          .moviesRecomended[index].releaseDate,false),
                                ),
                              );
                            },
                            itemCount:
                                PopularMoviesBloc.moviesRecomended.length,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

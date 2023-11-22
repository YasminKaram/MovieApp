import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Core/Utils/Constants.dart';

import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';

class PopularItem extends StatelessWidget {

   ResultsEntity resultEntity;


   PopularItem(this.resultEntity);

   @override
  Widget build(BuildContext context) {
    return Container(alignment: FractionalOffset.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        Center(
          child: Stack(
            children: [
              Container(
                  height: 250.h,
                  width: 200.w,
                  child: Image.network(
                      "${Constants.imagesurl}${resultEntity.posterPath ?? ""}")),
              Container(
                child: Icon(Icons.play_circle_outline_sharp, size: 20.sp),
              )
            ],
          ),
        )
      ]),
    );
  }
}

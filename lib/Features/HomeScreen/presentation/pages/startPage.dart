import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';
import 'package:movieapp/Core/Utils/AppStyles.dart';

import '../../../../Config/Routes.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0c1526),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/img.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 50.h,),

          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, RoutesName.homeLayout, (route) => false);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Watching Movies",style: AppStyles.headLine.copyWith(fontWeight: FontWeight.bold)),
                  Spacer(),
                  Icon(Icons.movie),

                ],
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.selectcolor,
                  fixedSize: Size(200.w, 60.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r))),
            ),
          ),
        ],
      ),
    );
  }
}

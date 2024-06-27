import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Config/Routes.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';
import 'package:movieapp/Core/Utils/AppStyles.dart';
import 'package:movieapp/Core/Utils/Components/CardAdded.dart';
import 'package:movieapp/Core/Utils/Components/CardofMovie.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';
import 'package:movieapp/Features/HomeScreen/presentation/widgets/SearchCard.dart';

class SearchScreen extends StatelessWidget {
  var text = TextEditingController();

// SearchScreen(this.text);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularMoviesBloc(),
      child: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                SearchBar(
                  trailing: <Widget>[
                    Tooltip(
                      message: 'remove',
                      child: IconButton(
                        onPressed: (){
                          text.clear();
                          PopularMoviesBloc.get(context).add(SearchMovie());
                        },
                      icon: Icon(Icons.dangerous_outlined,color: Colors.white, ),
                      ),
                    )
                  ],
                controller: text,
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                hintText: "Enter to Search",
                hintStyle: MaterialStatePropertyAll(
                    AppStyles.date.copyWith(fontSize: 15.sp)),
                backgroundColor:
                MaterialStatePropertyAll(AppColors.unselectcolor),
                leading: Icon(Icons.search,color: Colors.white),
                textStyle: MaterialStatePropertyAll(AppStyles.headLine),



                onTap: () {
                  PopularMoviesBloc.title=text.text;
                  PopularMoviesBloc.get(context).add(SearchMovie());
                },
                onChanged: (_) {
                  PopularMoviesBloc.title=text.text;
                  PopularMoviesBloc.get(context).add(SearchMovie());
                },
              ),
                  text.text!=""?
                  Expanded(
                    child: ListView.builder(itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          PopularMoviesBloc.id =PopularMoviesBloc
                              .searchMovie[index].id;
                          PopularMoviesBloc.idmoreLike =PopularMoviesBloc
                              .searchMovie[index].id;
                          PopularMoviesBloc.get(context)
                              .add(DetailsMovie());
                          PopularMoviesBloc.get(context)
                              .add(GetMoreLike());

                          Navigator.pushNamed(
                              context, RoutesName.movieDetails);
                        },
                          child: SearchCard(PopularMoviesBloc.searchMovie, index));
                    },itemCount: PopularMoviesBloc.searchMovie.length),
                  ):
                  SizedBox(
                    height: 200.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_movies_rounded,
                            color: AppColors.unselectcolor, size: 70.r),
                        Text(
                          "No Movies Found",
                          style: AppStyles.date.copyWith(fontSize: 18),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

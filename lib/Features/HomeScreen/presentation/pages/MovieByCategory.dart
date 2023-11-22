import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Config/Routes.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';
import 'package:movieapp/Core/Utils/Components/CardAdded.dart';
import 'package:movieapp/Core/Utils/Components/CardofMovie.dart';
import 'package:movieapp/Core/Utils/Constants.dart';
import 'package:movieapp/Features/HomeScreen/data/data_sources/Local/MoviesLocalDsImp.dart';
import 'package:movieapp/Features/HomeScreen/data/models/CategoryModel.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/CategoryEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/PopularMovies.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';
import 'package:movieapp/Features/HomeScreen/presentation/widgets/CategoryCard.dart';

class MovieByCategory extends StatelessWidget {
  const MovieByCategory({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => PopularMoviesBloc()..add(GetMoviesCategory()),
      child: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
        listener: (context, state) {
          if (state.screenStatus == ScreenStatus.movieCategoryloading) {
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
          if (state.screenStatus == ScreenStatus.movieCategorySuccess) {
            Navigator.pop(context);
          }

        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(title:Text("Movies"),backgroundColor: AppColors.selectcolor,centerTitle: true),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 10), itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          PopularMoviesBloc.id =PopularMoviesBloc
                              .moviescategory[index].id;
                          PopularMoviesBloc.idmoreLike =PopularMoviesBloc
                              .moviescategory[index].id;
                          PopularMoviesBloc.get(context)
                              .add(DetailsMovie());
                          PopularMoviesBloc.get(context)
                              .add(GetMoreLike());

                          Navigator.pushNamed(
                              context, RoutesName.movieDetails);
                        },
                        child: CategoryMovieCard(
                            PopularMoviesBloc.moviescategory[index].posterPath,
                            PopularMoviesBloc.moviescategory[index].select,
                            PopularMoviesBloc.moviescategory[index].title,
                            PopularMoviesBloc.moviescategory[index].voteAverage, index,
                            PopularMoviesBloc.moviescategory[index].releaseDate),
                      );
                    },
                    itemCount: PopularMoviesBloc.moviescategory.length,),
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

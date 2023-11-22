import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/Config/Routes.dart';
import 'package:movieapp/Core/Utils/AppStyles.dart';
import 'package:movieapp/Core/Utils/Components/CardAdded.dart';
import 'package:movieapp/Core/Utils/Constants.dart';
import 'package:movieapp/Features/HomeScreen/data/data_sources/Local/MoviesLocalDsImp.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/PopularMovies.dart';
import 'package:movieapp/Features/HomeScreen/presentation/bloc/popular_movies_bloc.dart';

class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularMoviesBloc()..add(GetFromFirebase()),
      child: BlocConsumer<PopularMoviesBloc, PopularMoviesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("WatchList",style: AppStyles.headLine.copyWith(fontSize: 18,fontWeight: FontWeight.bold),),
                StreamBuilder(
                  stream: MoviesLocalDsImp.getMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }
                    List<ResultsEntity> movies =
                        snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                    if (movies.isEmpty) {
                      return Center(child: Text("No Tasks"));
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                              onTap: () {
                                PopularMoviesBloc.id = movies[index].id;
                                PopularMoviesBloc.idmoreLike = movies[index].id;
                                PopularMoviesBloc.get(context)
                                    .add(DetailsMovie());
                                PopularMoviesBloc.get(context).add(GetMoreLike());

                                Navigator.pushNamed(
                                    context, RoutesName.movieDetails);
                              },
                              child: CardAdded(movies, index));
                        },
                        itemCount: movies.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

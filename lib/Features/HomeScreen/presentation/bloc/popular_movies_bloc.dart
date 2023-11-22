import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/Core/Api/ApiManager.dart';
import 'package:movieapp/Core/Error/Failures.dart';
import 'package:movieapp/Features/HomeScreen/data/data_sources/Local/MoviesLocalDsImp.dart';

import 'package:movieapp/Features/HomeScreen/data/data_sources/Remote/PopulraRemoteDs.dart';
import 'package:movieapp/Features/HomeScreen/data/data_sources/Remote/PopulraRemoteDsImpl.dart';

import 'package:movieapp/Features/HomeScreen/data/repositories/PopularRepoImp.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/CategoryEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/repositories/PopularRepo.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/GetCategory.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/GetDetailsMovie.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/GetMoviesbyCategory.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/NewRealeasesMovies.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/PopularMovies.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/RecomendedMovies.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/SearchMovie.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/getMoreLike.dart';

part 'popular_movies_event.dart';

part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  static PopularMoviesBloc get(context) => BlocProvider.of(context);
  static List<ResultsEntity> moviesPopular = [];
  static List<ResultsEntity> moviesRealese = [];
  static List<ResultsEntity> moviesRecomended = [];
  static List<GenresEntity> categoryList = [];
  static List<ResultsEntity> moviescategory = [];
  static List<ResultsEntity> searchMovie = [];
  static List<ResultsEntity> moreLikeMovie = [];

  static List<int> selected = [];
  static int? index;
  static int? id;
  static String? title;
  static int? categoryid;
  static ResultsEntity? entity;
  static int? idmoreLike;

  PopularMoviesBloc() : super(PopularMoviesInitial()) {
    on<PopularMoviesEvent>((event, emit) async {
      if (event is GetPopularEvent) {
        emit(state.copyWith(screenStatus: ScreenStatus.popularloading));
        print("yasso");
        ApiManager apiManager = ApiManager();
        PopularRemoteDs popularRemoteDs = PopularRemoteDsImpl(apiManager);
        PopularRepo popularRepo = PopularRepoImp(popularRemoteDs);
        PopularMovies popularMovies = PopularMovies(popularRepo);
        var entityData = await popularMovies.call();

        entityData?.fold((l) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.popularFailure,
              failures: RemoteFailures(l.toString())));
          print("ahm");
        }, (r) {
          moviesPopular = r.results ?? [];
          emit(state.copyWith(
              screenStatus: ScreenStatus.popularSuccess,
              popularEntity: r.results));
          print("yasso");
        });
      }
      if (event is GetRealeseEvent) {
        emit(state.copyWith(screenStatus: ScreenStatus.realeseloading));
        ApiManager apiManager = ApiManager();
        PopularRemoteDs popularRemoteDs = PopularRemoteDsImpl(apiManager);
        PopularRepo popularRepo = PopularRepoImp(popularRemoteDs);
        NewRealeasesMovies newRealeasesMovies = NewRealeasesMovies(popularRepo);
        var realesedata = await newRealeasesMovies.call();
        realesedata?.fold((l) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.realeseFailure,
              failures: RemoteFailures(l.toString())));
          print("ahmed");
        }, (r) {
          moviesRealese = r.results ?? [];
          emit(state.copyWith(
              screenStatus: ScreenStatus.realeseSuccess, Realese: r.results));
          print("yasso");
        });
      }
      if (event is GetRecomendedEvent) {
        emit(state.copyWith(screenStatus: ScreenStatus.recomendedloading));
        ApiManager apiManager = ApiManager();
        PopularRemoteDs popularRemoteDs = PopularRemoteDsImpl(apiManager);
        PopularRepo repo = PopularRepoImp(popularRemoteDs);
        RecomendedMovies recomendedMovies = RecomendedMovies(repo);
        var result = await recomendedMovies.call();
        result?.fold((l) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.recomendedFailure,
              failures: RemoteFailures(l.toString())));
          print("Noooo");
        }, (r) {
          moviesRecomended = r.results ?? [];
          emit(state.copyWith(
              screenStatus: ScreenStatus.recomendedSuccess,
              recomended: r.results));
        });
      }
      if (event is GetMoreLike) {
        emit(state.copyWith(screenStatus: ScreenStatus.moreLikemovieloading));
        ApiManager apiManager = ApiManager();
        PopularRemoteDs popularRemoteDs = PopularRemoteDsImpl(apiManager);
        PopularRepo repo = PopularRepoImp(popularRemoteDs);
        getMoreLike moreLike = getMoreLike(repo);
        var result = await moreLike.call(idmoreLike.toString());
        result?.fold((l) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.moreLikemovieFailure,
              failures: RemoteFailures(l.toString())));
          print("Noooo");
        }, (r) {
          moreLikeMovie = r.results ?? [];
          emit(state.copyWith(
              screenStatus: ScreenStatus.moreLikemovieSuccess,
              moreLikeMovie: r.results));
        });
      }

      if (event is DetailsMovie) {
        emit(state.copyWith(screenStatus: ScreenStatus.detailsloading));
        ApiManager apiManager = ApiManager();
        PopularRemoteDs popularRemoteDs = PopularRemoteDsImpl(apiManager);
        PopularRepo repo = PopularRepoImp(popularRemoteDs);
        GetDetailsMovie detailsMovie = GetDetailsMovie(repo);
        var result = await detailsMovie.call(PopularMoviesBloc.id.toString());

        result?.fold((l) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.detailsFailure,
              failures: RemoteFailures(l.toString())));
          print("Noooo");
        }, (r) {
          entity = r;
          emit(state.copyWith(screenStatus: ScreenStatus.detailsSuccess));
        });
      }
      if (event is GetCategory) {
        emit(state.copyWith(screenStatus: ScreenStatus.Categoryloading));
        ApiManager apiManager = ApiManager();
        PopularRemoteDs popularRemoteDs = PopularRemoteDsImpl(apiManager);
        PopularRepo repo = PopularRepoImp(popularRemoteDs);
        GetCategoryUsecase category = GetCategoryUsecase(repo);
        var result = await category.call();

        result?.fold((l) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.CategoryFailure,
              failures: RemoteFailures(l.toString())));
          print("Noooo");
        }, (r) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.CategorySuccess, categry: r.genres));
          categoryList = r.genres ?? [];
        });
      }
      if (event is GetMoviesCategory) {
        emit(state.copyWith(screenStatus: ScreenStatus.movieCategoryloading));
        ApiManager apiManager = ApiManager();
        PopularRemoteDs popularRemoteDs = PopularRemoteDsImpl(apiManager);
        PopularRepo repo = PopularRepoImp(popularRemoteDs);
        GetMoviesbyCategory category = GetMoviesbyCategory(repo);
        var result = await category.call(categoryid.toString());
        result?.fold((l) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.movieCategoryFailure,
              failures: RemoteFailures(l.toString())));
          print(l.toString());
          print("Noooo");
        }, (r) {
          moviescategory = r.results ?? [];
          emit(state.copyWith(
              screenStatus: ScreenStatus.movieCategorySuccess,
              movieCategory: r.results));
        });
      }
      if (event is SearchMovie) {
        emit(state.copyWith(screenStatus: ScreenStatus.Searchmovieloading));
        ApiManager apiManager = ApiManager();
        PopularRemoteDs popularRemoteDs = PopularRemoteDsImpl(apiManager);
        PopularRepo repo = PopularRepoImp(popularRemoteDs);
        SearchMovieUsecase Movie = SearchMovieUsecase(repo);
        var result = await Movie.call(title ?? "");
        result?.fold((l) {
          emit(state.copyWith(
              screenStatus: ScreenStatus.SearchmovieFailure,
              failures: RemoteFailures(l.toString())));
          print(l.toString());
          print("Noooo");
        }, (r) {
          searchMovie = r.results ?? [];
          emit(state.copyWith(
              screenStatus: ScreenStatus.SearchmovieSuccess,
              SearchMovie: r.results));
        });
      }

      if (event is ClickMarkRecomendedMovie) {
        if (PopularMoviesBloc.moviesRecomended[index!].select == false) {
          emit(AddMovieState());
          PopularMoviesBloc.moviesRecomended[index!].select = true;
          ResultsEntity resultsEntity =
              PopularMoviesBloc.moviesRecomended[index!];
          MoviesLocalDsImp.AddMovie(resultsEntity);
        } else {
          emit(RemoveMovieState());
          PopularMoviesBloc.moviesRecomended[index!].select = false;
          MoviesLocalDsImp.deletemovie(PopularMoviesBloc.moviesRecomended[index!].movieId!);
        }
      }
      if (event is ClickMarkEvent) {
        if (PopularMoviesBloc.moviesRealese[index!].select == false) {
          emit(AddMovieState());
          PopularMoviesBloc.moviesRealese[index!].select = true;
          ResultsEntity resultsEntity = PopularMoviesBloc.moviesRealese[index!];
          MoviesLocalDsImp.AddMovie(resultsEntity);
        } else {
          emit(RemoveMovieState());
          PopularMoviesBloc.moviesRealese[index!].select = false;
          MoviesLocalDsImp.deletemovie(PopularMoviesBloc.moviesRealese[index!].movieId!);
        }
      }
      if (event is ClickMarkCategoryEvent) {
        if (PopularMoviesBloc.moviescategory[index!].select == false) {
          emit(AddMovieState());
          PopularMoviesBloc.moviescategory[index!].select = true;
          ResultsEntity resultsEntity = PopularMoviesBloc.moviescategory[index!];
          MoviesLocalDsImp.AddMovie(resultsEntity);
        } else {
          emit(RemoveMovieState());
          PopularMoviesBloc.moviescategory[index!].select = false;
          MoviesLocalDsImp.deletemovie(PopularMoviesBloc.moviescategory[index!].movieId!);
        }
      }
      if (event is ClickMarkdetailsmovieEvent) {
        if (PopularMoviesBloc.entity?.select == false) {
          emit(AddMovieState());
          PopularMoviesBloc.entity?.select = true;
          ResultsEntity resultsEntity = PopularMoviesBloc.entity!;
          MoviesLocalDsImp.AddMovie(resultsEntity);
        } else {
          emit(RemoveMovieState());
          PopularMoviesBloc.entity?.select = false;
          MoviesLocalDsImp.deletemovie(PopularMoviesBloc.entity!.movieId!);
        }
      }

      if (event is ClickMarkmoreLikeEvent) {
        if (PopularMoviesBloc.moreLikeMovie[index!].select == false) {
          emit(AddMovieState());
          PopularMoviesBloc.moreLikeMovie[index!].select = true;
          ResultsEntity resultsEntity =
          PopularMoviesBloc.moreLikeMovie[index!];
          MoviesLocalDsImp.AddMovie(resultsEntity);
        } else {
          emit(RemoveMovieState());
          PopularMoviesBloc.moreLikeMovie[index!].select = false;
          MoviesLocalDsImp.deletemovie(PopularMoviesBloc.moreLikeMovie[index!].movieId!);
        }
      }

      if(event is ClickMarkRemoveEvent){
        MoviesLocalDsImp.deletemovie(PopularMoviesBloc.entity!.movieId!);

      }
      if (event is GetFromFirebase) {
        MoviesLocalDsImp.getMovies();
      }
    });
  }
}

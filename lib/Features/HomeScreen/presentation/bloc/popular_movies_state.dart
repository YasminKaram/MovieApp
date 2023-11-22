part of 'popular_movies_bloc.dart';

enum ScreenStatus {
  init,
  popularloading,
  popularSuccess,
  popularFailure,
  realeseloading,
  realeseSuccess,
  realeseFailure,
  recomendedloading,
  recomendedSuccess,
  recomendedFailure,
  selected,
  detailsloading,
  detailsSuccess,
  detailsFailure,
  Categoryloading,
  CategorySuccess,
  CategoryFailure,
  movieCategoryloading,
  movieCategorySuccess,
  movieCategoryFailure,
  Searchmovieloading,
  SearchmovieSuccess,
  SearchmovieFailure,
  moreLikemovieloading,
  moreLikemovieSuccess,
  moreLikemovieFailure,
}

@immutable
class PopularMoviesState {
  ScreenStatus? screenStatus;
  List<ResultsEntity>? popular;
  List<GenresEntity>? categry;
  List<ResultsEntity>? Realese;
  List<ResultsEntity>? recomended;
  List<ResultsEntity>? movieCategory;
  List<ResultsEntity>? SearchMovie;
  List<ResultsEntity>? moreLikeMovie;
  Failures? failures;

  PopularMoviesState(
      {this.SearchMovie,
      this.screenStatus,
      this.popular,
      this.failures,
      this.Realese,
      this.recomended,
      this.categry,
      this.movieCategory,this.moreLikeMovie});

  PopularMoviesState copyWith(
      {ScreenStatus? screenStatus,
        List<ResultsEntity>? moreLikeMovie,
      List<ResultsEntity>? popularEntity,
      List<ResultsEntity>? SearchMovie,
      List<ResultsEntity>? Realese,
      List<ResultsEntity>? recomended,
      List<GenresEntity>? categry,
      List<ResultsEntity>? movieCategory,
      Failures? failures}) {
    return PopularMoviesState(
      screenStatus: screenStatus ?? this.screenStatus,
      popular: popularEntity ?? this.popular,
      Realese: Realese ?? this.Realese,
      recomended: recomended ?? this.recomended,
      failures: failures ?? this.failures,
      categry: categry ?? this.categry,
      movieCategory: movieCategory ?? this.movieCategory,
      SearchMovie: SearchMovie ?? this.SearchMovie,
      moreLikeMovie: moreLikeMovie ??this.moreLikeMovie
    );
  }
}

class PopularMoviesInitial extends PopularMoviesState {
  PopularMoviesInitial() : super(screenStatus: ScreenStatus.init);
}

class AddMovieState extends PopularMoviesState {}

class RemoveMovieState extends PopularMoviesState {}

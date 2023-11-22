part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesEvent {}
class GetPopularEvent extends PopularMoviesEvent{}
class GetRealeseEvent extends PopularMoviesEvent{}
class GetRecomendedEvent extends PopularMoviesEvent{}
class ClickMarkEvent extends PopularMoviesEvent{}
class ClickMarkRecomendedMovie extends PopularMoviesEvent{}
class DetailsMovie extends PopularMoviesEvent{}
class GetFromFirebase extends PopularMoviesEvent{}
class GetCategory extends PopularMoviesEvent{}
class GetMoviesCategory extends PopularMoviesEvent{}
class SearchMovie extends PopularMoviesEvent{}
class ClickMarkCategoryEvent extends PopularMoviesEvent{}
class ClickMarkRemoveEvent extends PopularMoviesEvent{}
class ClickMarkdetailsmovieEvent extends PopularMoviesEvent{}
class GetMoreLike extends PopularMoviesEvent{}
class ClickMarkmoreLikeEvent extends PopularMoviesEvent{}

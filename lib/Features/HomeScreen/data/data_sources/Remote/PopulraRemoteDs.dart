 import 'package:dartz/dartz.dart';
import 'package:movieapp/Core/Error/Failures.dart';
import 'package:movieapp/Features/HomeScreen/data/models/CategoryModel.dart';
import 'package:movieapp/Features/HomeScreen/data/models/PopularModel.dart';


abstract class PopularRemoteDs{
   Future<Either<Failures, PopularModel>>? getPopular();
   Future<Either<Failures, PopularModel>>? getRealeses();
   Future<Either<Failures, PopularModel>>? getRecomended();
   Future<Either<Failures, Results>>? getDetailsMovie(String id);
   Future<Either<Failures, CategoryModel>>? GetCategory();
   Future<Either<Failures, PopularModel>>?GetMoviesbyCategory(String id);
   Future<Either<Failures, PopularModel>>?SearchMovie(String title);
   Future<Either<Failures, PopularModel>>? getMoreLike(String id);
}

import 'package:dartz/dartz.dart';
import 'package:movieapp/Core/Error/Failures.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/CategoryEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';


abstract class PopularRepo{
  Future<Either<Failures,PopularEntity>>?getPopular();
  Future<Either<Failures,PopularEntity>>? getRealeses();
  Future<Either<Failures,PopularEntity>>? getRecomended();
  Future<Either<Failures,ResultsEntity>>? getDetailsMovie(String id);
  Future<Either<Failures,CategoryEntity>>? GetCategory();
  Future<Either<Failures,PopularEntity>>? GetMoviesbyCategory(String id);
  Future<Either<Failures,PopularEntity>>? SearchMovie(String title);
  Future<Either<Failures,PopularEntity>>? getMoreLike(String id);


}
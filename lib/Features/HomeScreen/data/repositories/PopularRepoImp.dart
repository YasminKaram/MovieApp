
import 'package:dartz/dartz.dart';
import 'package:movieapp/Core/Error/Failures.dart';

import 'package:movieapp/Features/HomeScreen/data/data_sources/Remote/PopulraRemoteDs.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/CategoryEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/repositories/PopularRepo.dart';
import 'package:movieapp/Features/HomeScreen/domain/use_cases/GetMoviesbyCategory.dart';

class PopularRepoImp extends PopularRepo{
  PopularRemoteDs  populraRemoteDs;


  PopularRepoImp(this.populraRemoteDs);

  @override
  Future<Either<Failures, PopularEntity>> ?getPopular() {
    try{
      return populraRemoteDs.getPopular();

    }
    catch (e){
      throw(e);
    }
  }

  @override
  Future<Either<Failures, PopularEntity>> ?getRealeses() {
    try {
      return populraRemoteDs.getRealeses();

    }catch(e){
      throw(e);

    }
  }

  @override
  Future<Either<Failures, PopularEntity>>? getRecomended() {
   try{
     return populraRemoteDs.getRecomended();
   }
   catch(e){
     throw(e);

   }
  }

  @override
  Future<Either<Failures, ResultsEntity>>? getDetailsMovie(String id) {
    try{
      return populraRemoteDs.getDetailsMovie(id);
    }
    catch(e){
      throw(e);

    }
  }

  @override
  Future<Either<Failures, CategoryEntity>>? GetCategory() {
    try{
      return populraRemoteDs.GetCategory();
    }
    catch(e){
      throw(e);

    }
  }

  @override
  Future<Either<Failures, PopularEntity>>? GetMoviesbyCategory(String id) {
    try{
      return populraRemoteDs.GetMoviesbyCategory(id);

    }
    catch(e){
      throw(e);

    }
  }

  @override
  Future<Either<Failures, PopularEntity>>? SearchMovie(String title) {
    try{
      return populraRemoteDs.SearchMovie(title);

    }
    catch(e){
      throw(e);

    }
  }

  @override
  Future<Either<Failures, PopularEntity>>? getMoreLike(String id) {
    try{
      return populraRemoteDs.getMoreLike(id);

    }
    catch(e){
      throw(e);

    }
  }




}
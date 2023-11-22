import 'package:dartz/dartz.dart';
import 'package:movieapp/Core/Api/ApiManager.dart';
import 'package:movieapp/Core/Api/EndPoints.dart';
import 'package:movieapp/Core/Error/Failures.dart';
import 'package:movieapp/Features/HomeScreen/data/data_sources/Remote/PopulraRemoteDs.dart';
import 'package:movieapp/Features/HomeScreen/data/models/CategoryModel.dart';
import 'package:movieapp/Features/HomeScreen/data/models/PopularModel.dart';


class PopularRemoteDsImpl implements PopularRemoteDs {
  ApiManager apiManager;

  PopularRemoteDsImpl(this.apiManager);

  @override
  Future<Either<Failures, PopularModel>>? getPopular() async {
    try {
      var response = await apiManager.getData(EndPoints.popular);
      PopularModel popularModel = PopularModel.fromJson(response.data);
      return Right(popularModel);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, PopularModel>>? getRealeses() async{
    try{
       var response=await apiManager.getData(EndPoints.newrealese);
       PopularModel popularModel=PopularModel.fromJson(response.data);
       return Right(popularModel);
    }
    catch(e){
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<Failures, PopularModel>>? getRecomended() async{
    try{
       var result=await apiManager.getData(EndPoints.recomended);
       PopularModel recomended=PopularModel.fromJson(result.data);
       return Right(recomended);

    }catch(e){
      return Left(RemoteFailures(e.toString()));

    }

  }

  @override
  Future<Either<Failures, Results>>? getDetailsMovie(String id) async{
    try{
      var result=await apiManager.getData(EndPoints.details,id: id );
      Results details=Results.fromJson(result.data);
      return Right(details);

    }catch(e){
      return Left(RemoteFailures(e.toString()));

    }
  }

  @override
  Future<Either<Failures, CategoryModel>>? GetCategory()async {
    try{
      var result=await apiManager.getData(EndPoints.category );
      CategoryModel categoryModel =CategoryModel.fromJson(result.data);
      return Right(categoryModel);

    }catch(e){
      return Left(RemoteFailures(e.toString()));

    }
  }

  @override
  Future<Either<Failures, PopularModel>>? GetMoviesbyCategory(String id) async{
    try{
      var result=await apiManager.getData(EndPoints.MoviebyCat,id: id );
      PopularModel details=PopularModel.fromJson(result.data);
      return Right(details);

    }catch(e){
      return Left(RemoteFailures(e.toString()));

    }
  }

  @override
  Future<Either<Failures, PopularModel>>? SearchMovie(String title) async{
    try{
      var result=await apiManager.getData(EndPoints.search,id: title );
      PopularModel details=PopularModel.fromJson(result.data);
      return Right(details);

    }catch(e){
      return Left(RemoteFailures(e.toString()));

    }

  }

  @override
  Future<Either<Failures, PopularModel>>? getMoreLike(String id) async{
    try {
      var response = await apiManager.getData(EndPoints.details,id: id,similar: EndPoints.morelike);
      PopularModel popularModel = PopularModel.fromJson(response.data);
      return Right(popularModel);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }

  }
}

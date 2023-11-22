import 'package:dartz/dartz.dart';
import 'package:movieapp/Core/Error/Failures.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/repositories/PopularRepo.dart';

class PopularMovies{
  PopularRepo popularRepo;


  PopularMovies(this.popularRepo);

  Future<Either<Failures,PopularEntity>>?call()=>
      popularRepo.getPopular();

}

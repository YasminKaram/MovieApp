import 'package:dartz/dartz.dart';
import 'package:movieapp/Core/Error/Failures.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/repositories/PopularRepo.dart';

class SearchMovieUsecase {
  PopularRepo popularRepo;


  Future<Either<Failures, PopularEntity>>? call(String title) =>
      popularRepo.SearchMovie(title);

  SearchMovieUsecase(this.popularRepo);
}

import 'package:dartz/dartz.dart';
import 'package:movieapp/Core/Error/Failures.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/CategoryEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';

import 'package:movieapp/Features/HomeScreen/domain/repositories/PopularRepo.dart';

class GetMoviesbyCategory {
  PopularRepo popularRepo;


  GetMoviesbyCategory(this.popularRepo);

  Future<Either<Failures, PopularEntity>>? call(String id) =>
      popularRepo.GetMoviesbyCategory(id);
}

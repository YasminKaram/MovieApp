import 'package:dartz/dartz.dart';
import 'package:movieapp/Core/Error/Failures.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/CategoryEntity.dart';

import 'package:movieapp/Features/HomeScreen/domain/repositories/PopularRepo.dart';

class GetCategoryUsecase {
  PopularRepo popularRepo;


  GetCategoryUsecase(this.popularRepo);

  Future<Either<Failures, CategoryEntity>>? call() =>
      popularRepo.GetCategory();
}

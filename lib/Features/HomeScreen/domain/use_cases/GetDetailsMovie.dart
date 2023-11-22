import 'package:dartz/dartz.dart';
import 'package:movieapp/Core/Error/Failures.dart';
import 'package:movieapp/Features/HomeScreen/domain/entities/PopularEntity.dart';
import 'package:movieapp/Features/HomeScreen/domain/repositories/PopularRepo.dart';

class GetDetailsMovie {
  PopularRepo popularRepo;

  GetDetailsMovie(this.popularRepo);

  Future<Either<Failures, ResultsEntity>>? call(String id) =>
      popularRepo.getDetailsMovie(id);
}

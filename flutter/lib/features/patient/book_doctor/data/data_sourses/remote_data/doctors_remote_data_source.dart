

import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/patient/book_doctor/domain/entities/doctor_entity.dart';
import 'package:dartz/dartz.dart';

abstract class DoctorsRemoteDataSource {
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors();

  Future<Either<Failure, DoctorEntity>> getDoctorById({
    required String doctorId,
  });

  Future<Either<Failure, List<DoctorEntity>>> searchDoctors({
    required String keyword,
  });
}
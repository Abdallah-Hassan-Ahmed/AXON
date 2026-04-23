import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/patient/book_doctor/data/data_sourses/remote_data/doctors_remote_data_source.dart';
import 'package:Axon/features/patient/book_doctor/domain/entities/doctor_entity.dart';
import 'package:Axon/features/patient/book_doctor/domain/repo/doctors_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DoctorsRepo)
class DoctorsRepoImpl implements DoctorsRepo {
  final DoctorsRemoteDataSource doctorsRemoteDataSource;

  DoctorsRepoImpl({
    required this.doctorsRemoteDataSource,
  });

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    var either = await doctorsRemoteDataSource.getAllDoctors();

    return either.fold(
      (error) => Left(error),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, DoctorEntity>> getDoctorById({
    required String doctorId,
  }) async {
    var either = await doctorsRemoteDataSource.getDoctorById(
      doctorId: doctorId,
    );

    return either.fold(
      (error) => Left(error),
      (response) => Right(response),
    );
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors({
    required String keyword,
  }) async {
    var either = await doctorsRemoteDataSource.searchDoctors(
      keyword: keyword,
    );

    return either.fold(
      (error) => Left(error),
      (response) => Right(response),
    );
  }
}
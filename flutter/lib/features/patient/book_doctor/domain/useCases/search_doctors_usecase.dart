import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/patient/book_doctor/domain/entities/doctor_entity.dart';
import 'package:Axon/features/patient/book_doctor/domain/repo/doctors_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchDoctorsUseCase {
  final DoctorsRepo doctorsRepo;

  SearchDoctorsUseCase(this.doctorsRepo);

  Future<Either<Failure, List<DoctorEntity>>> invoke({
    required String keyword,
  }) {
    return doctorsRepo.searchDoctors(
      keyword: keyword,
    );
  }
}
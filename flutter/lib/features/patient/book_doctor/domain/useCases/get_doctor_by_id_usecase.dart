import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/features/patient/book_doctor/domain/entities/doctor_entity.dart';
import 'package:Axon/features/patient/book_doctor/domain/repo/doctors_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetDoctorByIdUseCase {
  final DoctorsRepo doctorsRepo;

  GetDoctorByIdUseCase(this.doctorsRepo);

  Future<Either<Failure, DoctorEntity>> invoke({
    required String doctorId,
  }) {
    return doctorsRepo.getDoctorById(
      doctorId: doctorId,
    );
  }
}
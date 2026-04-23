import 'package:Axon/core/errors/error_handler.dart';
import 'package:Axon/core/errors/exceptions.dart';
import 'package:Axon/core/errors/failures.dart';
import 'package:Axon/core/errors/mappers/exception_to_failure_mapper.dart';
import 'package:Axon/core/network/api_manager.dart';
import 'package:Axon/core/network/endpoints.dart';
import 'package:Axon/core/network/network_info.dart';
import 'package:Axon/features/patient/book_doctor/data/data_sourses/remote_data/doctors_remote_data_source.dart';
import 'package:Axon/features/patient/book_doctor/data/models/doctor_dm.dart';
import 'package:Axon/features/patient/book_doctor/domain/entities/doctor_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: DoctorsRemoteDataSource)
class DoctorsRemoteDataSourceImpl implements DoctorsRemoteDataSource {
  final NetworkInfo networkInfo;
  final ApiManager apiManager;

  DoctorsRemoteDataSourceImpl({
    required this.networkInfo,
    required this.apiManager,
  });

  @override
  Future<Either<Failure, List<DoctorEntity>>> getAllDoctors() async {
    try {
      if (!await networkInfo.isConnected) {
        throw OfflineException();
      }

      final response = await apiManager.get(
        Endpoints.getAllDoctors,
      );

      print("get all doctors response: $response");

      final List doctorsList = response["data"]["doctors"];

      final doctors = doctorsList
          .map((e) => DoctorDM.fromJson(e))
          .toList();

      return Right(doctors);
    } on DioException catch (e) {
      print("get all doctors error: ${e.response?.data}");
      return Left(mapExceptionToFailure(ErrorHandler.handle(e)));
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      print("unknown error: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, DoctorEntity>> getDoctorById({
    required String doctorId,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        throw OfflineException();
      }

      final response = await apiManager.get(
        "${Endpoints.getDoctorById}/$doctorId",
      );

      print("get doctor by id response: $response");

      final doctor = DoctorDM.fromJson(
        response["data"]["doctor"],
      );

      return Right(doctor);
    } on DioException catch (e) {
      print("get doctor by id error: ${e.response?.data}");
      return Left(mapExceptionToFailure(ErrorHandler.handle(e)));
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      print("unknown error: $e");
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<DoctorEntity>>> searchDoctors({
    required String keyword,
  }) async {
    try {
      if (!await networkInfo.isConnected) {
        throw OfflineException();
      }

      final response = await apiManager.post(
        Endpoints.searchDoctors,
        {
          "keyword": keyword,
        },
      );

      print("search doctors response: $response");

      final List doctorsList = response["data"]["doctors"];

      final doctors = doctorsList
          .map((e) => DoctorDM.fromJson(e))
          .toList();

      return Right(doctors);
    } on DioException catch (e) {
      print("search doctors error: ${e.response?.data}");
      return Left(mapExceptionToFailure(ErrorHandler.handle(e)));
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    } catch (e) {
      print("unknown error: $e");
      return Left(ServerFailure());
    }
  }
}
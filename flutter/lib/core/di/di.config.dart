// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart'
    as _i161;

import '../../features/auth/data/data_sourses/remote_data/auth_remote_data_source.dart'
    as _i223;
import '../../features/auth/data/data_sourses/remote_data/impl/auth_remote_data_source_impl.dart'
    as _i810;
import '../../features/auth/data/repo_impl/auth_repo_impl.dart' as _i279;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/domain/useCases/login_case.dart' as _i861;
import '../../features/auth/Presentation/manager/login/login_cubit.dart'
    as _i65;
import '../network/api_manager.dart' as _i119;
import '../network/network_info.dart' as _i932;
import '../network/network_module.dart' as _i200;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModule = _$NetworkModule();
    gh.singleton<_i119.ApiManager>(() => _i119.ApiManager());
    gh.lazySingleton<_i161.InternetConnection>(
      () => networkModule.internetConnection,
    );
    gh.lazySingleton<_i932.NetworkInfo>(
      () => _i932.NetworkInfoImpl(gh<_i161.InternetConnection>()),
    );
    gh.factory<_i223.AuthRemoteDataSource>(
      () => _i810.AuthRemoteDataSourceImpl(
        networkInfo: gh<_i932.NetworkInfo>(),
        apiManager: gh<_i119.ApiManager>(),
      ),
    );
    gh.factory<_i170.AuthRepo>(
      () => _i279.AuthRepoImpl(
        authRemoteDataSource: gh<_i223.AuthRemoteDataSource>(),
      ),
    );
    gh.factory<_i861.LoginUseCase>(
      () => _i861.LoginUseCase(gh<_i170.AuthRepo>()),
    );
    gh.factory<_i65.LoginCubit>(
      () => _i65.LoginCubit(loginUseCase: gh<_i861.LoginUseCase>()),
    );
    return this;
  }
}

class _$NetworkModule extends _i200.NetworkModule {}

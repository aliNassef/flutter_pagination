// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/quotes/data/repo/quotes_repo_impl.dart' as _i926;
import '../../features/quotes/presentation/quotes_cubit/quotes_cubit.dart'
    as _i526;
import '../../features/recipes/data/repo/recipe_repo_impl.dart' as _i238;
import '../../features/recipes/presentation/cubit/recipe_cubit.dart' as _i135;
import '../api/api_service.dart' as _i299;
import '../api/dio_helper.dart' as _i646;
import 'module_register.dart' as _i19;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i526.QuotesCubit>(() => _i526.QuotesCubit());
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i299.ApiService>(() => _i646.DioHelper(gh<_i361.Dio>()));
    gh.lazySingleton<_i926.QuotesRepoImpl>(
      () => _i926.QuotesRepoImpl(apiService: gh<_i299.ApiService>()),
    );
    gh.lazySingleton<_i238.RecipeRepoImpl>(
      () => _i238.RecipeRepoImpl(apiService: gh<_i299.ApiService>()),
    );
    gh.factory<_i135.RecipeCubit>(
      () => _i135.RecipeCubit(gh<_i238.RecipeRepoImpl>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i19.RegisterModule {}

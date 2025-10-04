
import 'package:bankemployers/core/connections/network_info.dart';
import 'package:bankemployers/core/databases/api/dio_consumer.dart';
import 'package:bankemployers/core/databases/api/interceptors.dart';
import 'package:bankemployers/core/databases/cache/cache_helper.dart';
import 'package:bankemployers/features/employers_auth/data/repo/singnup_emplyee.dart';
import 'package:bankemployers/features/employers_auth/view/viewmodel/auth_employee_cubit/cubit/employer_cubit.dart';
import 'package:bankemployers/features/empleyees_dashboard/data/repo/employes_repo.dart';
import 'package:bankemployers/features/empleyees_dashboard/view/viewmodel/all_user_cubit/alluser_cubit.dart';
import 'package:bankemployers/features/cvs/view/viewmodel/cubits/upload_cubit/upload_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  CacheHelper.sharedPreferences = sharedPreferences;

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper()); // ⬅️ السطر المهم

  sl.registerLazySingleton<LoggerInterceptor>(() => LoggerInterceptor());

  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.interceptors.add(sl<LoggerInterceptor>());
    return DioConsumer(dio: dio);
  });

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<UploadCubit>(() => UploadCubit( sl())); //
  sl.registerLazySingleton<EmployesRepo>(() => EmployesRepo(dioConsumer: DioConsumer(dio: Dio())));


    sl.registerLazySingleton<EmployerCubit>(() => EmployerCubit( sl())); //
    sl.registerLazySingleton<AlluserCubit>(() => AlluserCubit( sl())); //
sl.registerLazySingleton<SingnupEmplyee>(() => SingnupEmplyee( DioConsumer(dio: Dio()))); //
  
}

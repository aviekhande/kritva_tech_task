import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kritva_tech_task/core/config/app_bloc_observer.dart';
import 'package:kritva_tech_task/core/constants/app_strings.dart';
import 'package:kritva_tech_task/core/routes/app_router.dart';
import 'package:kritva_tech_task/core/theme/colors.dart';
import 'package:kritva_tech_task/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  // INIT APP DEPENDENCIES
  await initDependencies();

  Bloc.observer = AppBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = serviceLocator<AppRouter>();
    return ScreenUtilInit(
      designSize: const Size(412, 917),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      child: SafeArea(
        bottom: true,
        top: false,
        left: false,
        right: false,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp.router(
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light, // Android
                  statusBarBrightness: Brightness.dark, // iOS
                ),
                child: MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(0.94)),
                  child: child!,
                ),
              );
            },
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter.config,
            title: AppStrings.kAppTitle,
            theme: ThemeData(
              scaffoldBackgroundColor: AppColors.kColorPrimaryBg,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
          ),
        ),
      ),
    );
  }
}

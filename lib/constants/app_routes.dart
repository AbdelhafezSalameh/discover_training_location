import 'package:discover_training_location/admin_panel/main.dart';
import 'package:discover_training_location/admin_panel/screens/main/main_screen.dart';
import 'package:discover_training_location/features/auth/presentation/screens/forgot_password.dart';
import 'package:discover_training_location/features/auth/presentation/screens/login_screen.dart';
import 'package:discover_training_location/features/auth/presentation/screens/register_screen.dart';
import 'package:discover_training_location/features/auth/presentation/screens/reset_password.dart';
import 'package:discover_training_location/features/auth/presentation/screens/verify_code.dart';
import 'package:discover_training_location/features/company_main_screen.dart';
import 'package:discover_training_location/features/full_page_job.dart';
import 'package:discover_training_location/features/home/company_home_screen.dart';
import 'package:discover_training_location/features/home/home_screen.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:discover_training_location/features/map_screen.dart';
import 'package:discover_training_location/features/widgets/user_profile.dart';
import 'package:discover_training_location/utils/splash_screen.dart';
import 'package:discover_training_location/utils/success_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._();

  static Map<String, WidgetBuilder> routes() {
    return {
      NamedRoutes.splashScreen: (context) => const SplashScreen(),
      NamedRoutes.logIn: (context) => const LogIn(),
      NamedRoutes.registerScreen: (context) => const RegisterScreen(),
      NamedRoutes.forgotPassword: (context) => const ForgotPassword(),
      NamedRoutes.successScreen: (context) => const SuccessScreen(),
      NamedRoutes.resetPassword: (context) => ResetPassword(),
      NamedRoutes.verifyCode: (context) => const VerifyCode(),
      NamedRoutes.homeScreen: (context) => const HomeScreen(),
      NamedRoutes.fullPageJob: (context) => const FullPageJob(),
      NamedRoutes.userProfile: (context) => UserProfile(),
      // NamedRoutes.testScreen: (context) => TestScreen(),
      NamedRoutes.companyMainScreen: (context) => const CompanyMainScreen(),
      NamedRoutes.companyHomeScreen: (context) => const CompanyHomeScreen(),
            NamedRoutes.mapScreen: (context) => const MapScreen(),
            NamedRoutes.adminMainScreen: (context) =>  MainScreen(),
            NamedRoutes.admin: (context) =>  MyApp(),

    };
  }
}

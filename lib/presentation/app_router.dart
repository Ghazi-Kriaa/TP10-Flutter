import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../business_logic/cubit/phone_auth/cubit/phone_auth_cubit.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/map_screen.dart';
import '../presentation/screens/otp_screen.dart';
import '../constants/strings.dart';
class AppRouter {
 PhoneAuthCubit? phoneAuthCubit;
 AppRouter() {
 phoneAuthCubit = PhoneAuthCubit();
 }
 Route? generateRoute(RouteSettings settings) {
 switch (settings.name) {
 case mapScreen:
 return MaterialPageRoute(
 builder: (_) => MapScreen(),
 );
 case loginScreen:
 return MaterialPageRoute(
 builder: (_) => BlocProvider<PhoneAuthCubit>.value(
 value: phoneAuthCubit!,
 child: LoginScreen(),
 ),
 );
 case otpScreen:
 final phoneNumber = settings.arguments;
 return MaterialPageRoute(
 builder: (_) => BlocProvider<PhoneAuthCubit>.value(
 value: phoneAuthCubit!,
 child: OtpScreen(phoneNumber: phoneNumber),
 ),
 );
 }
 }
}
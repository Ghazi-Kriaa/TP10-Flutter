import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubit/phone_auth/cubit/phone_auth_cubit.dart';
import '../../constants/strings.dart';
class MapScreen extends StatefulWidget {
 const MapScreen({Key? key}) : super(key: key);
 @override
 State<MapScreen> createState() => _MapScreenState();
}
class _MapScreenState extends State<MapScreen> {
PhoneAuthCubit phoneauthcubit = PhoneAuthCubit();
 @override
 Widget build(BuildContext context) {
 return Scaffold(
 body: Center(
 child:
 Container(
 padding: const EdgeInsets.all(20),
 child: BlocProvider<PhoneAuthCubit>(
 create: (context) => phoneauthcubit,
 child: ElevatedButton(
 onPressed:() async{
 await phoneauthcubit.logOut();
 Navigator.of(context).pushReplacementNamed(loginScreen);

 },
 style:ElevatedButton.styleFrom(
 minimumSize: const Size(110,50),
 primary: Colors.black,
 shape:RoundedRectangleBorder(borderRadius:
BorderRadius.circular(6))
 ),
 child: const Text(
 'LogOut',
 style: TextStyle(
 color: Colors.white,
 fontSize :16,
 ),
 ),
 ),
 ),
 ),
 ),
 );
 }
} 
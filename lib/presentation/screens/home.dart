import 'package:flutter/material.dart';
import '../../constants/strings.dart';
class Home extends StatelessWidget {
 const Home({Key? key}) : super(key: key);
 @override
 Widget build(BuildContext context) {
 return Container (
 child: ElevatedButton(
 child: const Text("Enter"),
 onPressed: () =>{
 Navigator.pushNamed(context, loginScreen),
 }
 ),
 );
 }
} 
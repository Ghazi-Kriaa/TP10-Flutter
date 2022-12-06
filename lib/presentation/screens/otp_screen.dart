import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../business_logic/cubit/phone_auth/cubit/phone_auth_cubit.dart';
import '../../constants/my_colors.dart';
import '../../constants/strings.dart';

class OtpScreen extends StatelessWidget {
 OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);
 final phoneNumber;
late String otpCode;
 Widget _buildIntroTexts() {
 return Column(
 crossAxisAlignment: CrossAxisAlignment.start,
 children: [
 const Text(
 "Verify your phone number",
 style: TextStyle(
 color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
 ),
 const SizedBox(
 height: 20,
 ),
 Container(
 margin: const EdgeInsets.symmetric(horizontal: 2),
 child: RichText(
 text: TextSpan(
 text: "Enter your digit code number sent to",
 style: const TextStyle(
 color: Colors.black,
 fontSize: 18,
 height: 1.4,
 ),
 children: <TextSpan>[
 TextSpan(
 text: '$phoneNumber',
 style: const TextStyle(
 color: MyColors.blue,
 ),
 ),
 ],
 ),
 ),
 ),
 ],
 );
 }
 Widget _buildPinCodeFields(BuildContext context) {
 return Container(
 child: PinCodeTextField(
 appContext: context,
 autoFocus: true,
 cursorColor: Colors.black,
 keyboardType: TextInputType.number,
 length: 6,
 obscureText: false,
 animationType: AnimationType.scale,
 pinTheme: PinTheme(
 shape: PinCodeFieldShape.box,
 borderRadius: BorderRadius.circular(5),
 fieldHeight: 50,
 fieldWidth: 40,
 borderWidth: 1,
 activeColor: MyColors.blue,
 inactiveColor: MyColors.blue,
 activeFillColor: MyColors.lightblue,
 inactiveFillColor: Colors.white,
 selectedColor: MyColors.blue,
 selectedFillColor: Colors.white,
 ),
 animationDuration: const Duration(milliseconds: 300),
 backgroundColor: Colors.white,
 enableActiveFill: true,
 onCompleted: (submitedCode) {
 this.otpCode = submitedCode;
 print("Completed");
 },
 onChanged: (value) {
 print(value);

 },
 ),
 );
 }
 void _login(BuildContext context) async{
await BlocProvider.of<PhoneAuthCubit>(context).submitOTP(this.otpCode);
}
Widget _buildVerifyButton(BuildContext context){
 return Align(
 alignment: Alignment.centerRight,
 child : ElevatedButton(
 onPressed:(){
 showProgressIndicator(context);
 _login(context);
 },
 style:ElevatedButton.styleFrom(
minimumSize: const Size(110,50),
primary: Colors.black,
shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
 ),
 child: const Text(
 'Verify',
 style: TextStyle(
 color: Colors.white,
 fontSize :16,
 ),
 ),
),
);
}
void showProgressIndicator(BuildContext context){

 AlertDialog alertDialog = const AlertDialog(
 backgroundColor: Colors.transparent,
 elevation:0,
 content: Center(
 child: CircularProgressIndicator(valueColor:
AlwaysStoppedAnimation<Color>(Colors.black)),
 ),
 );
showDialog(
 barrierColor: Colors.white.withOpacity(0),
 barrierDismissible: false,
 context: context,
 builder: (context){
 return alertDialog;
}
);
}
Widget _buildPhoneVerificationBloc(){
 return BlocListener<PhoneAuthCubit,PhoneAuthState>(
 listenWhen: (previous, current){
 return previous != current;
 },
listener : (context,state){
 if(state is Loading){
 showProgressIndicator(context);
 }
if(state is PhoneOTPVerified){
 Navigator.pop(context);
 Navigator.of(context).pushReplacementNamed(mapScreen);
}
if(state is ErrorOccured){
//Navigator.pop(context);
 String errorMsg = (state).errorMsg;
 ScaffoldMessenger.of(context).showSnackBar(
 SnackBar(
 content : Text(errorMsg),
 backgroundColor : Colors.black,
 duration : const Duration(seconds:10),
 ),
 );
}
},
child : Container(),
 );
} 

 Widget build(BuildContext context) {
 return SafeArea(
 child: Scaffold(
 backgroundColor: Colors.white,
 body: Container(
 margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
 child: Column(
 children: [
 _buildIntroTexts(),
 const SizedBox(
 height: 30,
 ),
 _buildPinCodeFields(context),
 const SizedBox(
 height: 40,
 ),
_buildVerifyButton(context),
 _buildPhoneVerificationBloc(), 
 ],
 ),
 ),
 ),
 );
 }
} 
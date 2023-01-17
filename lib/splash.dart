import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {

  void initState(){
    super.initState();
    navigator();
  }
  navigator()async{
    await Future.delayed(Duration(milliseconds: 4500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>login()));
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.pink[200],
          ),
          child: Text('Capstone',style: GoogleFonts.sacramento(
              fontSize: 48,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.italic,
              color: Colors.white),),

        ),
      ),
    );
  }
}

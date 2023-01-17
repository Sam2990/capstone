import 'package:capstone/login.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'package:glassmorphism/glassmorphism.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController emailsignup = TextEditingController();
  TextEditingController passwordsignup = TextEditingController();
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 144,
                    ),
                    Text('Capstone',style: GoogleFonts.sacramento(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: Colors.white),),
                    SizedBox(
                      height:10,
                    ),
                    Text('Join with us to help you out!',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 16
                    ),)
                  ],
                ),
              ),
              alignment: Alignment.topLeft,
              height: 320,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.pink[200],
                borderRadius: BorderRadius.only(bottomLeft:Radius.circular(100)),
              ),
            ),
            SizedBox(
              height: 84,
            ),
            GlassmorphicContainer(
              width: 280,
              height: 400,
              blur: 15,
              border: 2,
              borderRadius: 12,
              linearGradient:  LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white38.withOpacity(0.2)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderGradient: LinearGradient(colors: [
                Colors.white24.withOpacity(0.2),
                Colors.white70.withOpacity(0.2)
              ]),
              child: Column(
                children: [
                  Text('SIGNUP PAGE',style: GoogleFonts.aBeeZee(
                    color: Colors.pink[400],
                    //fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: emailsignup,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email,color: Colors.pink[200],),
                        hintText: 'Enter Email',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordsignup,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock,color: Colors.pink[200]),
                        hintText: 'Password',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    width: 280,
                    height: 58,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink[200],
                            // side: BorderSide(width:3, color:Colors.transparent), //border width and color
                            elevation: 3, //elevation of button
                            shape: RoundedRectangleBorder( //to set border radius to button
                                borderRadius: BorderRadius.circular(12)
                            ),
                            padding: EdgeInsets.all(20)
                        ),
                        onPressed: ()async{
                          try{
                            final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email : emailsignup.text.trim(),
                              password: passwordsignup.text.trim(),
                            );
                            FirebaseFirestore.instance.collection(emailsignup.text.trim()+'date').doc('date').set(
                              {
                                'date':DateTime(now.year,now.month,now.day)
                              }
                            );
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>login()));

                          }on FirebaseAuthException catch(e){
                            if(e.code == 'week-password'){
                              const snackBar = SnackBar(
                                content: Text('week-password'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }else if(e.code == 'email-already-in-use'){
                              const snackBar = SnackBar(
                                content: Text('email-already-in-use'),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            }
                          }catch(e){
                            const snackBar = SnackBar(
                              content: Text('something gone wrong try  again with other email and(or) password'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }

                        }, child: Text('Signup',style: GoogleFonts.aBeeZee(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

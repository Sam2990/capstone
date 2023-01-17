import 'package:capstone/signup.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController emaillogin =TextEditingController();
  TextEditingController passwordlogin =TextEditingController();
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
                    Text('Welcome back, you.ve been missed! ',style: GoogleFonts.aBeeZee(
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
                Colors.white.withOpacity(0.2)
              ]),
              child: Column(
                children: [
                  Text('LOGIN PAGE',style: GoogleFonts.aBeeZee(
                      color: Colors.pink[400],
                    //fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),),
                  SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: emaillogin,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email,color: Colors.pink[200],),
                        hintText: 'Email',
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
              ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    obscureText: true,
                    controller: passwordlogin,
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
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: emaillogin.text.trim(),
                          password: passwordlogin.text.trim(),
                        );  print(emaillogin.toString());
                        emaillogin.clear();
                        passwordlogin.clear();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>home()));
                      } on FirebaseAuthException catch(e){
                        if(e.code=='user-not-found'){
                          const snackBar = SnackBar(
                            content: Text('user-not-found'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }else if(e.code == 'wrong-password'){
                          const snackBar = SnackBar(
                            content: Text('wrong-password'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    }, child: Text('Login',style: GoogleFonts.aBeeZee(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),)),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Text('Have no account?'),
                      SizedBox(
                        width: 88,
                      ),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>signup()));
                      }, child:Text('Sign up',style: GoogleFonts.aBeeZee(
                        color: Colors.pink,
                        fontSize: 16,
                      ),))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

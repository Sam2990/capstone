import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class showtask extends StatelessWidget {
  //const showtask({Key? key}) : super(key: key);
  String id;
  bool done;
  String title;
  showtask({required this.id,required this.done,required this.title});



 String call(){
   return id;
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(backgroundColor:Colors.pink[200],title: Text(title,style: GoogleFonts.aBeeZee(
        fontSize: 20
      ),),),
      body: Center(
        child: GlassmorphicContainer(
          width: MediaQuery.of(context).size.width*0.8,
          height:  MediaQuery.of(context).size.height*0.6,
          blur: 15,
          border: 2,
          borderRadius: 12,
          linearGradient:  LinearGradient(
              colors: [
                Colors.pink.withOpacity(0.2),
                Colors.white38.withOpacity(0.2)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderGradient: LinearGradient(colors: [
            Colors.white24.withOpacity(0.2),
            Colors.white.withOpacity(0.2)
          ]),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width*0.7,
              height: MediaQuery.of(context).size.height*0.6,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('You’ll never change your life until you change something you do daily.  The secret to your success is found in your daily routine. ',style: GoogleFonts.cedarvilleCursive(
                    fontSize: 20,
                    //color: Colors.pink[200],
                  ),),
                  SizedBox(
                    height: 40,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Text('Mark this as done '),

                      TextButton(onPressed: (){
                        FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email!).doc(id).update(
                            {
                              'done':!done
                            });
                        Navigator.of(context).pop();
                      }, child: Text('Change the status'))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text('Delete this task?'),
                      SizedBox(
                        width: 48,
                      ),
                      TextButton(onPressed: (){
                        FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email!).doc(id).delete();
                        Navigator.of(context).pop();
                      }, child: Text('DELETE'))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

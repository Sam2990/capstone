import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

class addtask extends StatefulWidget {
  const addtask({Key? key}) : super(key: key);

  @override
  State<addtask> createState() => _addtaskState();
}

class _addtaskState extends State<addtask> {
  TextEditingController tasktitle = TextEditingController();
  TextEditingController taskdiscription = TextEditingController();
  TextEditingController tasktype = TextEditingController();

  Future<void>?addmsg(String task,String email,String? title,String type) async {
    await FirebaseFirestore.instance.collection(email).add({"titletask":title,"titlediscription":task,"type":type,"done":false,"time":FieldValue.serverTimestamp()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(backgroundColor:Colors.pink[200],title: Text('Capstone',style: GoogleFonts.sacramento(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: Colors.white),),),
      body: Center(
        child:GlassmorphicContainer (
          width: MediaQuery.of(context).size.width*0.9,
          height:  MediaQuery.of(context).size.height*0.7,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 280,
                height: 480,
                child: Column(
                  children: [
                    Text('We are what we repeatedly do. Excellence, then, is not an act, but a habit...',style: GoogleFonts.cedarvilleCursive(
                      fontSize: 16,
                      //color: Colors.pink[200],
                    ),),
                    SizedBox(
                      height: 16,
                    ),
                    Text('ADD TASK',style: GoogleFonts.aBeeZee(
                      fontSize: 16,
                      color: Colors.pink,
                    ),),
                    SizedBox(
                      height: 36,
                    ),
                    TextField(
                      controller: tasktitle,
                      decoration: InputDecoration(
                          hintText: 'Enter Task Title',
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: taskdiscription,
                      decoration: InputDecoration(
                          hintText: 'Enter Task Discription',
                          contentPadding: const EdgeInsets.all(15),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: tasktype,
                      decoration: InputDecoration(
                          hintText: 'What type of task is this?',
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
                        onPressed: (){
                          addmsg(taskdiscription.text.trim(), FirebaseAuth.instance.currentUser!.email!,tasktitle.text.trim(),tasktype.text.trim());
                          tasktitle.clear();
                          taskdiscription.clear();
                          Navigator.of(context).pop();
                        }, child: Text('Add Task',style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

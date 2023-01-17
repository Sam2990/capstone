import 'package:capstone/addtask.dart';
import 'package:capstone/showtask.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final auth= FirebaseAuth.instance;
  List<Map<DateTime,int>>m=[];
  
  proceed(List<Map<DateTime,int>>info){
    for(int i=0;i<info.length;i++){
      return info[i];
    }
  }
  
  @override
  // initState() {
  //   super.initState();
  //
  //   FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email!+'date').doc('date').get().then((value){
  //     DocumentSnapshot documentSnapshot=value;
  //     DateTime datelast =documentSnapshot['date'];
  //   });
    DateTime datetoday = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);

  String userEmail=" ";
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(backgroundColor:Colors.pink[200],title: Text('Capstone',style: GoogleFonts.sacramento(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.italic,
          color: Colors.white),),),
      drawer: Drawer(
        backgroundColor: Colors.pink[200],
          child:Column(
            children: [
              SizedBox(
                height:40,
              ),
              Text('YOUR TASK',style: GoogleFonts.aBeeZee(
                fontSize: 16,

              ),),
              SingleChildScrollView(
                child: Container(
                  height: 400,

                  child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                            .collection(FirebaseAuth.instance.currentUser!.email!)
                            .orderBy("done")
                            .snapshots(),
                              builder: ( BuildContext context,AsyncSnapshot snapshot){
                              if(snapshot.hasError){
                              return const Text('has error');
                                }else if(snapshot.connectionState == ConnectionState.waiting){
                                  return Center(
                                     child: CircularProgressIndicator(),
                  );
                              }else if(snapshot.hasData){
                     return ListView.builder(

                      itemCount: snapshot.data!.docs.length,
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index){
                        if(snapshot.data!.docs.length <1){
                        return Text('..');
                      }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:GlassmorphicContainer (
                            width: MediaQuery.of(context).size.width,
                            height: 120,
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
                            child: Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    tileColor: Colors.grey[200],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>showtask(id:snapshot.data!.docs[index].id ,done: snapshot.data!.docs[index]['done'], title: snapshot.data!.docs[index]['titletask'],
                                      )));
                                    },
                                    leading:snapshot.data!.docs[index]['done']== true? Icon(Icons.done_all):Icon(Icons.add_alarm_sharp),

                                    title:Text( snapshot.data!.docs[index]['titletask'],style: GoogleFonts.aBeeZee(
                                      color: Colors.pink,
                                    )),
                                    subtitle: Text(snapshot.data!.docs[index]['titlediscription'],style: GoogleFonts.aBeeZee(
                                      color: Colors.pink[200],
                                    )),
                                    isThreeLine: true,

                                    trailing: Icon(Icons.edit),

                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0,right: 8),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Center(child: Text('Task type : '+snapshot.data!.docs[index]['type'],style: GoogleFonts.aBeeZee(
                                        color: Colors.pink[200],
                                      ),)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      // return message(user: user, name: snapshot.data!.docs[index]['name'],
                      //     msg: snapshot.data!.docs[index]['msg']) ;
                          });
                      }else{
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 200,
              ),
            ],
          )
                ),
      floatingActionButton: FloatingActionButton(

        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>addtask()));
        },
        child: Icon(Icons.add_task),
        backgroundColor: Colors.pink[200],
        enableFeedback: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text('Task Previously completed',style: GoogleFonts.aBeeZee(
                  fontSize: 16,
                  color: Colors.pink
              ),),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.pink[100],
                  ),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection(FirebaseAuth.instance.currentUser!.email!+'date')
                        .orderBy("date")
                        .snapshots(),
                    builder: (context, snapshot) {
                      List listchart = snapshot.data!.docs.map((e) {
                        Timestamp t;
                        t=e.data()['date'] as Timestamp;
                        DateTime date;
                        date = t.toDate();
                        return{
                          'domain':(date.year.toString()+'-'+date.month.toString()+'-'+date.day.toString()).toString(),
                          'measure':e.data()['donetask']
                        };
                      }).toList();
                      return AspectRatio(
                        aspectRatio: 16/9,
                      child: DChartBar(
                        data: [
                          {
                            'id':'bar',
                            'data':listchart,
                          }
                        ],
                        axisLineColor: Colors.black54,
                        barColor: (barData, index, id) => Colors.white70,
                        showBarValue: true,
                        barValueColor: Colors.green,
                      ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text('Task left today',style: GoogleFonts.aBeeZee(
                fontSize: 16,
                color: Colors.pink
              ),),
              Column(
                children: [
                  // Text('Task left today',style: GoogleFonts.aBeeZee(
                  //     fontSize: 16,
                  //     color: Colors.pink
                  // ),),
                  Container(
                    height: 280,

                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection(FirebaseAuth.instance.currentUser!.email!)
                          .orderBy("done")
                          .snapshots(),
                      builder: ( BuildContext context,AsyncSnapshot snapshot){
                        if(snapshot.hasError){
                          return const Text('has error');
                        }else if(snapshot.connectionState == ConnectionState.waiting){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }else if(snapshot.hasData){
                          return ListView.builder(

                              itemCount: snapshot.data!.docs.length,
                              reverse: true,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context,index){
                                if(snapshot.data!.docs.length <1){
                                  return Text('..');
                                }
                                else if(snapshot.data!.docs[index]['done']==false){
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: ListTile(
                                        tileColor: Colors.pink[200],
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>showtask(id:snapshot.data!.docs[index].id, done: snapshot.data!.docs[index]['done'], title: snapshot.data!.docs[index]['titletask'] ,
                                          )));
                                        },
                                        leading:snapshot.data!.docs[index]['done']== true? Icon(Icons.done_all):Icon(Icons.add_alarm_sharp),

                                        title:Text( snapshot.data!.docs[index]['titletask']),
                                        subtitle: Text(snapshot.data!.docs[index]['titlediscription']),
                                        trailing: Icon(Icons.edit),

                                      ),
                                    ),
                                  );
                                }else{
                                  return Padding(padding: EdgeInsets.all(2));
                                }
                                      // return message(user: user, name: snapshot.data!.docs[index]['name'],
                                //     msg: snapshot.data!.docs[index]['msg']) ;
                              });
                        }else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
  void getCurrentUserInfo() async {
    userEmail= await FirebaseAuth.instance.currentUser!.email!;
  }
}

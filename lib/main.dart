import 'package:capstone/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'splash.dart';
import 'package:glassmorphism/glassmorphism.dart';

void callbackDispatcher(){
  Workmanager().executeTask((taskName, inputData) {
    int donetask=0;
    int totaltask;
    int index=0;
    DateTime datetoday = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
   // while(true){
      StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirebaseAuth.instance.currentUser!.email!)
              .orderBy("done")
              .snapshots(),
          builder: ( BuildContext context,AsyncSnapshot snapshot){

            if(snapshot.hasData){
              if(snapshot.data!.docs[index]['done']==true){
                donetask++;
                snapshot.data!.docs[index].update({
                  "done":false
                });
              }
            }

            index++;
            return Padding(padding: EdgeInsets.zero);
          });
    //};
    FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email!+'date').add({
             'date':datetoday,
              'day':DateTime.now().weekday,
              'donetask':donetask,
              'totaltask':index
          });

    return Future.value(true);
  });
}

void main () async{
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher);


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override

  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if(DateTime.now().hour>21&&DateTime.now().hour<8){
    Workmanager().registerPeriodicTask('task0', 'taskName',frequency: Duration(days: 1), );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.pink[200],
    debugShowCheckedModeBanner: false,
        home:splash()
    );
  }
}

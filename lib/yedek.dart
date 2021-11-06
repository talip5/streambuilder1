import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import './error.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page59'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String baslik="StreamBuilder";
  String deneme='deneme35';

  void Error2(){
    FirebaseFirestore.instance.collection('data').snapshots();
    AsyncSnapshot<QuerySnapshot> snapshot;
    if (snapshot.connectionState == ConnectionState.done) {
      print('tamam');
    }
    else{
      print('olmadı');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(baslik),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text(deneme,style: TextStyle(fontSize: 25.0)),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('data').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData){
                  return Center(
                    //child: CircularProgressIndicator(),
                    child: Error1(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Error1();
                }
                return ListView(
                  children: snapshot.data.docs.map((document1){
                    return Center(
                      child: Container(
                        child: ListTile(
                          title: Text('title'+'  '+document1['userId']+'   '+document1['title'],style: TextStyle(fontSize: 25.0),),
                          leading: Icon(Icons.add_a_photo),
                          trailing: Icon(Icons.map),
                          onTap: (){
                            setState(() {
                              baslik=document1['userId'];
                              deneme=document1['title'];
                            });
                            print(document1['userId']);
                            print('Stream builder');
                          },
                        ),
                        width: MediaQuery.of(context).size.width/1.2,
                        height: MediaQuery.of(context).size.height/16,
                        /*child: Text(
                            ('title:' +document1['title']),style: TextStyle(fontSize: 25.0),
                        ),*/
                      ),
                    );
                  }).toList(),
                );

              },
            ),
          ),
          RaisedButton(
            child: Text('Deneme'),
            color: Colors.green,
            onPressed: (){
              setState(() {
                Error2();
              });
            },
          ),
        ],
      ),
    );
  }
}

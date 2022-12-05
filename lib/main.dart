import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController t = TextEditingController();
  TextEditingController t1 = TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref("user/");
  List<User> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RealTime Database"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: t,
          ),
          TextField(
            controller: t1,
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                await ref.push().set({
                  "name": "${t.text}",
                  "contact": "${t1.text}",
                });
                t.clear();
                t1.clear();
              },
              child: Text("Submit")),
          ElevatedButton(
              onPressed: () {
                DatabaseReference starCountRef =
                    FirebaseDatabase.instance.ref('user/');
                starCountRef.onValue.listen((DatabaseEvent event) {
                  Map data = event.snapshot.value as Map;
                  list.clear();
                  data.forEach((key, value) {
                    User u = User.fromjson(value, key);
                    list.add(u);
                  });
                  setState(() {

                  });
                });
              },
              child: Text("View")),
        ],
      ),
    );
  }
}

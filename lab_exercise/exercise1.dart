import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                Icon(Icons.arrow_back, size: 30.0),
                Icon(Icons.home, size: 30.0),
                Icon(Icons.settings, size: 30.0)
              ])),
        ),
        body: Column(children: [
          Row(children: [
            Image(
              image: NetworkImage(
                  "https://t4.ftcdn.net/jpg/01/04/78/75/360_F_104787586_63vz1PkylLEfSfZ08dqTnqJqlqdq0eXx.jpg"),
              width: 300,
              height: 300,
            ),
          ]),
          SingleChildScrollView(
            child: Text("1975 PorscheCarrera 911 Carrera",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
          ),
          Row(
            children: [
              Container(
                child: const Row(children: [
                  Icon(
                    Icons.thumb_up,
                    size: 20.0,
                  ),
                  Text("0"),
                  Icon(
                    Icons.thumb_up,
                    size: 20.0,
                  ),
                  Text("0"),
                  Icon(
                    Icons.thumb_up,
                    size: 20.0,
                  ),
                  Text("Share"),
                ]),
              ),
            ],
          ),
          Container(
            child: const Column(children: [
              Text("0"),
              Text("Essential Information"),
              Text("1 of 3 done "),
              Icon(
                Icons.home,
                size: 20.0,
              ),
              Text("Year:"),
              Text("Make"),
              Text("Model:"),
              Text("VIN:91183288932"),
              Row(
                children: [
                  Icon(
                    Icons.fork_right,
                  ),
                  Text("Description"),
                  Icon(
                    Icons.home,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.fork_right,
                  ),
                  Text("Photot"),
                  Icon(
                    Icons.home,
                  ),
                ],
              )
            ]),
          ),
        ]));
  }
}

class children {
  const children({required double size});
}

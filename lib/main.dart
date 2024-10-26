import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widgets en Flutter'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: Text('Hola Mundo.. again', style: TextStyle(fontSize: 24, color: Colors.black)),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Uno'),
                  Text('Dos'),
                  Text('Tres'),
                ],
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    width: 300,
                    height: 200,
                    color: Colors.blue[100],
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Text('Encima', style: TextStyle(fontSize: 20, color: Colors.black)),
                  )
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber, width: 2),
                ),
                child: Text('Texto dentro de un Container'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


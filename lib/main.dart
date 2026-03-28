import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // constrictor
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyApp ):',
      home: Calcule(),
    );
  }
}

class Calcule extends StatefulWidget {
  const Calcule({super.key});
  @override
  CalculeState createState() => CalculeState();
}

class CalculeState extends State<Calcule> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();

  String somme = "";
  String produit = "";
  String soustration = "";
  String division = "";

  void calculer() {
    int? num1 = int.tryParse(num1Controller.text);
    int? num2 = int.tryParse(num2Controller.text);

    if (num1 != null && num2 != null) {
      setState(() {
        somme = (num1 + num2).toString();
        produit = (num1 * num2).toString();
        soustration = (num1 - num2).toString();

        if (num2 == 0) {
          division = "error num2=0";
        } else {
          division = (num1 / num2).toString();
        }
        num1Controller.clear();
        num2Controller.clear();
      });
    } else {
      setState(() {
        somme = "0";
        produit = "0";
        soustration = "0";
        division = "0";

        num1Controller.clear();
        num2Controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Icon(Icons.calculate),
        title: Text(
          "Calculatrice",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text('Calculator', style: TextStyle(fontSize: 28)),
            ),
            SizedBox(height: 10),
            TextField(
              controller: num1Controller,
              decoration: InputDecoration(
                labelText: "number-1",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: num2Controller,
              decoration: InputDecoration(
                labelText: "number-2",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: calculer, child: Text("calculer")),
            SizedBox(height: 40),
            Row(
              children: [
                Text(
                  'somme :  ',
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                Text(
                  '${somme.toString()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'produit :  ',
                  style: TextStyle(fontSize: 20, color: Colors.pink),
                ),
                Text(
                  '${produit.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'division :  ',
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                Text(
                  '${division.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'soustration :  ',
                  style: TextStyle(fontSize: 20, color: Colors.brown),
                ),
                Text(
                  '${soustration.toString()}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

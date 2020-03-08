import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoIMC = "Seu resultado aparecerá aqui";

  AssetImage _reaction = AssetImage("");

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoIMC = "Seu resultado aparecerá aqui";
      _reaction = AssetImage("");
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoIMC = "Resultado: ${imc.toStringAsPrecision(
            3)} \nEstá abaixo do peso!\nCOMA!!!";
        _reaction = AssetImage("images/hamburguer.png");
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoIMC =
        "Resultado: ${imc.toStringAsPrecision(3)} \nPeso ideal, parabéns!";
        _reaction = AssetImage("images/palmas.png");
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoIMC = "Resultado: ${imc.toStringAsPrecision(
            3)} \nLevemente acima do peso, cuidado!";
        _reaction = AssetImage("images/joinhaNegativo.png");
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoIMC = "Resultado: ${imc.toStringAsPrecision(
            3)} \nObesidade grau 1, cuide-se!";
        _reaction = AssetImage("images/chocado.png");
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoIMC = "Resultado: ${imc.toStringAsPrecision(
            3)} \nObesidade grau 2, cuide-se já!";
        _reaction = AssetImage("images/remedio.png");
      } else if (imc >= 40.0) {
        _infoIMC = "Resultado: ${imc.toStringAsPrecision(
            3)} \nObesidade grau 3, procure um médico!";
        _reaction = AssetImage("images/morreu.png");
      }
    });
  }

  void _showCard(){
    new Card(
      child: Container(
        color: Colors.black26,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
                "Desenvolvedor -> Gabriel Castro"
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      //Resolve erro - bottom overflowed by N pixels

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("IMC .koddo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _showCard,
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _resetFields();
        },
        label: Text("Zerar"),
        icon: Icon(Icons.autorenew),
        backgroundColor: Colors.lightBlue,
      ),

      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        //padding: EdgeInsets.fromLTRB(0, 20.0, 0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width, //largura com máximo da tela
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.lightBlueAccent, Colors.deepPurpleAccent],
                  ),
                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
                  //color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 5, bottom: 10, left: 25, right: 25
                  ),
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage("images/imc.koddo.png"),
                        height: 150,
                        width: 250,
                      ),

                      Container(
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Colors.black26,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Peso em kg",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                              controller: weightController,
                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Insira o seu peso, uai!";
                                }
                              },
                            ),
                          ),
                        ),

                      Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Colors.black26,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Altura em cm",
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                              controller: heightController,
                              // ignore: missing_return
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Insira a tua altura, oxe!";
                                }
                              },
                            ),
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                        child: Container(
                          height: 55.0,
                          width: MediaQuery.of(context).size.width, //largura com máximo da tela
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.lightBlueAccent, Colors.lightBlue],
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                _calculate();
                              }
                            },
                            child: Text(
                              "Calcular",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Container(
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Colors.white, Colors.white70],
                            ),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Container(
                                  width: MediaQuery.of(context).size.width, //largura com máximo da tela
                                  height: 200,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      _infoIMC,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black54,
                                      ),
                                    ),

                                    Image(
                                      image: _reaction,
                                    )
                                  ],
                                ),
                              )
                          )
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }}

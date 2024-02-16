import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fact = "";

  Future<void> getData() async {
   
      Dio dio = Dio();
      Response response = await dio.get("https://catfact.ninja/fact");
      CatFact model = CatFact.fromJson(response.data);

      final translator = GoogleTranslator();
      Translation translation =
          await translator.translate(model.fact!, from: 'en', to: 'ru');
      fact = translation.text;
      setState(() {});
    } 
  

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color.fromARGB(255, 251, 211, 235),
      appBar: AppBar(
        
        backgroundColor: Color.fromARGB(255, 251, 168, 194),
        title: const Center(child: Text('Facts about Cats')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Text(
                fact,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 251, 168, 194),
                  side: const BorderSide(color: Colors.black, width: 3)),
              onPressed: getData,
              child: const Text(
                'Get Fact',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CatFact {
  String? fact;
  int? length;

  CatFact({this.fact, this.length});

  CatFact.fromJson(Map<String, dynamic> json) {
    fact = json['fact'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fact'] = fact;
    data['length'] = length;
    return data;
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Expanded(
        child: Center(
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('assets/Create account page.png'),
          ),
        ),
      ),
    );
  }
}
/*Container(
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFa8c0ff),
              Color(0xFF3f2b96),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 150), // Add top margin
              const SizedBox(
                height: 100,
                child: Text(
                  "Log-in With",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3f2b96),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add spacing between widgets
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(75,50)),
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shadowColor: MaterialStateProperty.all(Colors.blueGrey),
                ),
                onPressed: null,
                child: const Text(
                    "Phone Number",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add spacing between widgets
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(150,50)),
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                  shadowColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: null,
                child: const Text(
                    "Email-Id",
                  style: TextStyle(
                    color: Colors.black
                  ),
                ),
              )
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
 */
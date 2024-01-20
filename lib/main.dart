import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mis_lab3/dialog.dart';
import 'package:mis_lab3/widget_tree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: WidgetTree(),
    );
  }
}

class Exam {
  String subject;
  bool isPartial;
  DateTime date;
  String lab;

  Exam(this.subject, this.isPartial, this.date, this.lab);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Exam> exams = [
    Exam("MIS", true, DateTime.utc(2024, 1, 2), "LAB 215"),
    Exam("MIS1", true, DateTime.utc(2024, 1, 2), "LAB 2")
  ];

  void addExam(Exam newExam) {
    setState(() {
      exams.add(newExam);
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0, // Adjust the horizontal gap
                mainAxisSpacing: 16.0,
              ),
              itemCount: exams.length,
              itemBuilder: (BuildContext context, index) {
                return Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          exams[index].subject,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(exams[index].isPartial ? 'Partial exam' : 'Exam'),
                        Text(
                            "Date: ${exams[index].date.day}/${exams[index].date.month}/${exams[index].date.year}"),
                        Text(exams[index].lab)
                      ],
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) {
            return AddExam(
              onExamAdded: addExam,
            );
          },
        ),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}

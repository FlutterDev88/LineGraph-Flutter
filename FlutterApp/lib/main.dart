import 'package:flutter/material.dart';
import 'package:line_graph/notifier_data.dart';
import 'package:line_graph/widget_graph.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NotifierData()),
      ],
      child: MaterialApp(
        title: 'Weight Graph',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Graph'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: WidgetGraph(),
      ),
    );
  }

}

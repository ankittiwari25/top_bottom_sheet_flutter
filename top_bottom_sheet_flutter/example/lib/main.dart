import 'package:flutter/material.dart';
import 'package:top_bottom_sheet_flutter/top_bottom_sheet_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Top Bottom Sheet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _showSheet() {
    TopModalSheet.show(
        context: context,
        isShowCloseButton: true,
        closeButtonRadius: 20.0,
        closeButtonBackgroundColor: Colors.white,
        child: Container(
          color: Colors.white,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: const Text('Ankit Tiwari'),
                  subtitle: const Text('tiwariankit496@gmail.com'),
                  leading: FloatingActionButton(
                    heroTag: index,
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: const FlutterLogo(),
                  ),
                );
              },
              itemCount: 30,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: ElevatedButton(
                onPressed: _showSheet, child: const Text('Show'))));
  }
}

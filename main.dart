import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomNavDemo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
        accentColor: Colors.redAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pageWidgets = [
    Text("One"),
    Text("Two"),
    Text("Three"),
    Text("Four"),
    Text("Five")
  ];

  int pg = 0;
  List pgStack = [];

  void pgPush(i) {
    if (pgStack.isEmpty) {
      pgStack.add(pg);
    }

    if (i == pg) {
      return;
    }
    
    if (pgStack.contains(i) && pgStack.length!=1) {
      pgStack.remove(i);
    }
    
    if (!pgStack.contains(pg)) {
      pgStack.add(pg);
    }

    setState(() {
      pg = i;
    });

    print(pgStack.toString());
  }
  
 Future<bool> pgPop(BuildContext context) {
  if (pgStack.isEmpty) {
      print("App terminated!");
      return Future<bool>.value(true);
  } else {
    int t = pgStack.removeLast();
    setState(() {
      pg = (pg!=t) ? t : pgStack.removeLast(); 
    });
  }
  print(pgStack.toString());
}

  @override
  Widget build(BuildContext context) {
    // handle back navigation
    return WillPopScope(
      onWillPop: () => pgPop(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("BottomNavDemo"),
        ),
        body: Center(child: pageWidgets[pg]),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.flash_on), title: Text("Trends")),
            BottomNavigationBarItem(
                icon: Icon(Icons.subscriptions), title: Text("Subs")),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail), title: Text("Inbox")),
            BottomNavigationBarItem(
                icon: Icon(Icons.folder), title: Text("Library")),
          ],
          currentIndex: pg,
          type: BottomNavigationBarType.fixed,
          onTap: (i) {
            pgPush(i);
          },
        ),
      ),
    );
  }
}

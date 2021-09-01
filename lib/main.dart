import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/chat.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'list_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ListModel> _list = <ListModel>[];

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 1; i <= 10; i++) {
      _list.add(ListModel(
          i,
          WordPair.random(maxSyllables: 5).asUpperCase,
          WordPair.random(maxSyllables: 30).asLowerCase,
          'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.juimg.com%2Ftuku%2Fyulantu%2F140703%2F330746-140F301555752.jpg&refer=http%3A%2F%2Fimg.juimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1632964880&t=c00dcbbab1f8d9f9c64f91872d881689',
          DateTime.now(),
          false));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('聊天界面'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(0),
        itemBuilder: (context, i) {
          if (_list.length == 0) return Divider();
          return GestureDetector(
            child: Container(
              child: Slidable(
                child: Container(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network(
                        _list[i].logo,
                        key: Key('key_$i'),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      Padding(padding: EdgeInsets.only(right: 8.0)),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    _list[i].name,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    DateFormat.Hm().format(_list[i].dateTime),
                                    style: TextStyle(color: Colors.grey),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  _list[i].message,
                                  style: TextStyle(color: Colors.grey),
                                )),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 8.0)),
                    ],
                  ),
                ),
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: [
                  SlideAction(
                    color: Colors.blue,
                    onTap: () {
                      _head(i, _list[i].isHead);
                    },
                    child: Text('置顶'),
                  ),
                  SlideAction(
                    color: Colors.red,
                    onTap: () {
                      _delete(i);
                    },
                    child: Text('删除'),
                  ),
                ],
              ),
              decoration: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.grey, width: .5),
                  insets: EdgeInsets.zero),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChatPage(title: _list[i].name);
              }));
            },
          );
        },
        itemCount: _list.length,
      ),
    );
  }

  void _head(int i, bool head) {
    setState(() {
      _list[i].isHead = !head;
      _list.sort((left, right) {
        if (left.isHead == right.isHead) {
          return -1;
        }
        return 1;
      });
    });
  }

  void _delete(int i) {
    setState(() {
      _list.removeAt(i);
      _list.sort((left, right) {
        if (left.isHead == right.isHead) {
          return -1;
        }
        return 1;
      });
    });
    // final snackBar = new SnackBar(
    //   content: new Text(
    //     title,
    //     style: TextStyle(color: Colors.red),
    //   ),
    //   backgroundColor: Colors.white,
    // );
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

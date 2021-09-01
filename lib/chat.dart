import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'message_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  FocusNode _focusNode = FocusNode();
  List<MessageModel> _messages = <MessageModel>[];

  @override
  void initState() {
    var dateTime = DateTime.now();
    for (int i = 1; i <= 10; i++) {
      _messages.add(MessageModel(
          'https://tse1-mm.cn.bing.net/th/id/R-C.99c17a64707822ed071aa73b0f41fd02?rik=XHL2flZ2h8wgEw&riu=http%3a%2f%2fwww.dnzhuti.com%2fuploads%2fallimg%2f170323%2f95-1F323144449.jpg&ehk=aYX9ubjmsW26aNvEe2oJRJwuS%2bR8VHXQk0P3gqFgUd8%3d&risl=&pid=ImgRaw&r=0',
          WordPair.random().asLowerCase,
          dateTime.add(Duration(seconds: i)),
          i % 3 == 0 ? false : true));
    }
    _focusNode.addListener(() {
      toDown();
    });
    super.initState();
    toDown();
  }

  void toDown() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (mounted) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, i) {
                if (_messages.length == 0) return Divider();
                var item = _messages[i];
                return Row(
                  mainAxisAlignment: item.isSend
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: _messageBox(item),
                );
              },
              itemCount: _messages.length,
            ),
          ),
          Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        print(_controller.text);
                        if (_controller.text.isNotEmpty) {
                          this.setState(() {
                            _messages.add(MessageModel(
                                'https://tse1-mm.cn.bing.net/th/id/R-C.99c17a64707822ed071aa73b0f41fd02?rik=XHL2flZ2h8wgEw&riu=http%3a%2f%2fwww.dnzhuti.com%2fuploads%2fallimg%2f170323%2f95-1F323144449.jpg&ehk=aYX9ubjmsW26aNvEe2oJRJwuS%2bR8VHXQk0P3gqFgUd8%3d&risl=&pid=ImgRaw&r=0',
                                _controller.text,
                                DateTime.now(),
                                true));
                          });
                          _controller.clear();
                          toDown();
                        }
                      },
                      color: Colors.blue,
                      icon: Icon(Icons.send),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: OutlineInputBorder(
                      // borderSide: BorderSide(color: Colors.grey, width: 0),
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // borderSide: BorderSide(color: Colors.grey, width: 0),
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    // border: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _messageBox(MessageModel message) {
    List<Widget> widgets = <Widget>[];

    var image = Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
      child: Image.network(
        message.logo,
        fit: BoxFit.cover,
        height: 30,
        width: 30,
      ),
    );
    var text = Container(
      padding: EdgeInsets.all(8.0),
      // color: item.isSend ? Colors.green : Colors.white,
      child: Text(
        message.message,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
      decoration: BoxDecoration(
        color: message.isSend ? Colors.green : Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
    if (message.isSend) {
      widgets.add(text);
      widgets.add(image);
    } else {
      widgets.add(image);
      widgets.add(text);
    }
    return widgets;
  }
}

import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  List<ChatMessage> _messages = [];

  bool _isWritting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: Column(children: [
          Flexible(
              child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _messages.length,
            itemBuilder: (_, i) => _messages[i],
            reverse: true,
          )),
          const Divider(
            height: 1,
          ),
          //TODO: Caja de texto
          Container(
            color: Colors.white,
            height: 100,
            child: _inputChat(),
          )
        ]),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String texto) {
              setState(() {
                if (texto.trim().length > 0) {
                  _isWritting = true;
                } else {
                  _isWritting = false;
                }
              });
            },
            decoration:
                const InputDecoration.collapsed(hintText: 'Send Message'),
            focusNode: _focusNode,
          )),
          //Botón de enviar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _isWritting
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                    child: const Text('Send'),
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: const Icon(
                          Icons.send,
                        ),
                        onPressed: _isWritting
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                      ),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
        text: texto,
        uid: '123',
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 400)));
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _isWritting = false;
    });
  }

  @override
  void dispose() {
    // TODO: Off del socket

    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }

    super.dispose();
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 1,
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Center(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              maxRadius: 14,
              backgroundColor: Colors.blue[100],
              child: const Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              'Jezer Diaz',
              style: TextStyle(color: Colors.black87, fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

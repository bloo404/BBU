import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:practical_exam/models/entity.dart';
import 'package:practical_exam/widgets/pop_up_dialog.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class DataNotification extends StatelessWidget {
  final channel = WebSocketChannel.connect(Uri.parse('ws://localhost:2305'));

  DataNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        builder: (context, snapshot) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (snapshot.hasData) {
              var data = Entity.fromJson(jsonDecode(snapshot.data.toString()));
              popUpDialog(context, "New entity added", data.toString());
            }
          });
          return const Text('');
        },
        stream: channel.stream.asBroadcastStream());
  }
}

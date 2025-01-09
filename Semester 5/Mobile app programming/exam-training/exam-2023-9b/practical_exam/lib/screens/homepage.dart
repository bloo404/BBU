// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:practical_exam/api/network.dart';
import 'package:practical_exam/screens/main_section.dart';
import 'package:practical_exam/screens/manage_section.dart';
import 'package:practical_exam/widgets/notification.dart';
import 'package:practical_exam/widgets/pop_up_dialog.dart';
import '../widgets/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ServerConnectivity connectivity = ServerConnectivity();
  bool online = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkServerStatus();
  }

  Future<void> _checkServerStatus() async {
    Timer.periodic(const Duration(seconds: 3), (Timer timer) async {
      bool isServerConnected =
          await ServerConnectivity().checkServerConnectivity();

      if (isServerConnected && !online) {
        showSnackBar(context, 'Server connected');
      }

      if (!isServerConnected && online) {
        showSnackBar(context, 'Server disconnected');
      }

      setState(() {
        online = isServerConnected;
      });
    });
  }

  Widget _buildSectionButton(String title, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Owners App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSectionButton('Main section', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainSection(online: online)),
              );
            }),
            _buildSectionButton('Search section', () {
              if (online) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ManageSection()),
                );
              } else {
                popUpDialog(
                    context, "Error", "This feature is not available offline");
              }
            }),
            online ? DataNotification() : Container()
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';

class FriendInviteScreen extends StatelessWidget {
  const FriendInviteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text('FriendInviteScreen'),
      ),
    );
  }
}
// flutter
import 'package:flutter/material.dart';
// packages
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sns/domain/firestore_user/firestore_user.dart';
// constants
import 'package:flutter_sns/constants/strings.dart';

class PassiveUserProfilePage extends ConsumerWidget {
  const PassiveUserProfilePage({
    Key? key,
    required this.passiveUser,
  }) : super(key: key);
  final FirestoreUser passiveUser;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(profileTitle),
        ),
        body: Container(
            alignment: Alignment.center, child: Text(passiveUser.uid)));
  }
}

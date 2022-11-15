// dart
import 'dart:io';
// flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
// constants
import 'package:flutter_sns/constants/others.dart';
import 'package:flutter_sns/constants/strings.dart';
// domain
import 'package:flutter_sns/domain/follower/follower.dart';
import 'package:flutter_sns/domain/firestore_user/firestore_user.dart';
import 'package:flutter_sns/domain/following_token/following_token.dart';
// model
import 'package:flutter_sns/models/main_model.dart';

final profileProvider = ChangeNotifierProvider(((ref) => ProfileModel()));

class ProfileModel extends ChangeNotifier {
  File? croppedFile;

  Future<String> uploadImageAndGetURL(
      {required String uid, required File file}) async {
    final String fileName = returnJpgFileName();
    final Reference storageRef = FirebaseStorage.instance
        .ref()
        .child("users")
        .child(uid)
        .child(fileName);
    // users/uid/ファイル名 にアップロード
    await storageRef.putFile(file);
    // users/uid/ファイル名 のURLを取得している
    return storageRef.getDownloadURL();
  }

  Future<void> uploadUserImage(
      {required DocumentSnapshot<Map<String, dynamic>> currentUserDoc}) async {
    final XFile xFile = await returnXFile();
    final File file = File(xFile.path);
    final String uid = currentUserDoc.id;
    croppedFile = await returnCroppedFile(xFile: xFile);
    final String url = await uploadImageAndGetURL(uid: uid, file: file);
    await currentUserDoc.reference.update({
      'userImageURL': url,
    });
    notifyListeners();
  }

  Future<void> follow(
      {required MainModel mainModel,
      required FirestoreUser passiveFirestoreUser}) async {
    // settings
    mainModel.followingUids.add(passiveFirestoreUser.uid);
    final String tokenId = returnUuidV4();
    final Timestamp now = Timestamp.now();
    final FollowingToken followingToken = FollowingToken(
        createdAt: now, passiveUid: passiveFirestoreUser.uid, tokenId: tokenId);
    final FirestoreUser activeUser = mainModel.firestoreUser;
    // 自分がフォローした印
    await FirebaseFirestore.instance
        .collection("users")
        .doc(activeUser.uid)
        .collection("tokens")
        .doc(tokenId)
        .set(followingToken.toJson());
    // 受動的なユーザーがフォローされたdataを生成する
    final Follower follower = Follower(
        createdAt: now,
        followedUid: passiveFirestoreUser.uid,
        followerUid: activeUser.uid);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveFirestoreUser.uid)
        .collection("followers")
        .doc(activeUser.uid)
        .set(follower.toJson());
  }

  Future<void> unfollow(
      {required MainModel mainModel,
      required FirestoreUser passiveFirestoreUser}) async {
    mainModel.followingUids.remove(passiveFirestoreUser.uid);
    // followしているTokenを取得する
    final FirestoreUser activeUser = mainModel.firestoreUser;
    // qshotというdataの塊の存在を存在を取得
    final QuerySnapshot<Map<String, dynamic>> qshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(activeUser.uid)
        .collection("tokens")
        .where("passiveUid", isEqualTo: passiveFirestoreUser.uid)
        .get();
    // 1個しか取得してないけど複数している扱い
    final List<DocumentSnapshot<Map<String, dynamic>>> docs = qshot.docs;
    final DocumentSnapshot<Map<String, dynamic>> token = docs.first;
    await token.reference.delete();
    // 受動的なユーザーがフォローされたdataを削除する
    await FirebaseFirestore.instance
        .collection("users")
        .doc(passiveFirestoreUser.uid)
        .collection("followers")
        .doc(activeUser.uid)
        .delete();
  }
}

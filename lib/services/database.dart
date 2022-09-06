import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  Future<QuerySnapshot<Map<String, dynamic>>> getUserByUserName(
      String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserByUserEmail(
      String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  Future<void> uploadUserInfo(String name, String email) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'email': email,
      'name': name,
    }).catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
  }

  createChatRoom(String chatroomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatroomId)
        .set(chatRoomMap)
        .catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      // ignore: avoid_print
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatRooms(String userName) {
    return FirebaseFirestore.instance
        .collection("ChatRoom")
        // .where("users", arrayContains: userName)
        .snapshots();
  } // bruh your database is not returning anything your logic is not true for db but you dont know how to search or you are missing some part of vedio code
}

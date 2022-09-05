import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:social_wall/service/auth_service.dart';


class MessageService {

  final AuthService authService = AuthService();

  final cloud.FirebaseFirestore _firestore = cloud.FirebaseFirestore.instance;

  auth.User? get getCurrentUser => authService.getCurrentUser;


  Stream<cloud.QuerySnapshot<Map<String, dynamic>>> messageStream(){
    return _firestore
        .collection('messages')
        .orderBy('ts', descending: true)
        .snapshots();
  }
  Future<void> sendMessage(String messageText) async {
    await _firestore.collection('messages').add({
      'text': messageText,
      'sender': authService.getUserEmail,
      'ts': cloud.Timestamp.now(),
    });
  }

}
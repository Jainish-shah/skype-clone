//contains the function expaination like how to communicate further to different functions of firebase method 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skpye_clone/models/message.dart';
import 'package:skpye_clone/models/user.dart';
import 'package:skpye_clone/resources/firebase_methods.dart';

class FirebaseRepository {
  FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<FirebaseUser> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<FirebaseUser> signIn() => _firebaseMethods.signIn();

  Future<bool> authenticateUser(FirebaseUser user) => _firebaseMethods.authenticateUser(user);

  Future<void> addDataToDb(FirebaseUser user) => _firebaseMethods.addDataToDb(user);

  //reponsible for signing out
  Future<void> signOut() => _firebaseMethods.signOut();

  Future<List<User>> fetchAllUsers(FirebaseUser user) => _firebaseMethods.fetchAllUsers(user);

  //Future<User> fetchUserDetailsById(String uid) => _firebaseMethods.fetchUserDetailsById(uid);

   Future<void> addMessageToDb(Message message, User sender, User receiver) => _firebaseMethods.addMessageToDb(message, sender, receiver);
}
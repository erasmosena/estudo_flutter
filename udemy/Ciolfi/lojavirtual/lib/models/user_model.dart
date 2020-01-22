import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  

  static UserModel of(BuildContext context){
    return ScopedModel.of<UserModel>(context);
  }

  @override
  void addListener(VoidCallback listener){
    super.addListener(listener);
    _loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    isLoading = true;
    notifyListeners();
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((user) async {
      firebaseUser = user.user;

      onSuccess();
      await _saveUserData(userData);
    }).catchError((e) {
      onFail();
    }).whenComplete(() {
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("user")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) firebaseUser = await _auth.currentUser();
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot document = await Firestore.instance
            .collection("user")
            .document(firebaseUser.uid)
            .get();
        userData = document.data;
      }
    }
    notifyListeners();
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
          firebaseUser = user.user ; 
          await _loadCurrentUser();
           onSuccess();

        })
        .catchError((e){
           onFail();
        })
        .whenComplete((){
          isLoading = false;
          notifyListeners();
        });
  }

  void recoverPass({
      @required String email,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {

        _auth.sendPasswordResetEmail(email:email).then((data){
          onSuccess();
        }).catchError((e){
          onFail();
          print(e.toString());
        });
    
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }
}

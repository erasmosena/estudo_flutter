import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase{

  final _usersController = BehaviorSubject<List>();

  Stream<List> get outUsers => _usersController.stream;

  Map<String,Map<String,dynamic>> _users = {} ;
  
  Firestore _firestore = Firestore.instance;

  UserBloc(){
    _addUsersListener();
  }

  void _addUsersListener(){
    _firestore.collection("user").snapshots().listen((snapshot){
      snapshot.documentChanges.forEach((change){
        String uid = change.document.documentID;
        switch (change.type) {
          
          case DocumentChangeType.added:
            _users[uid] = change.document.data;
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(change.document.data);
            _usersController.add(_users.values.toList());
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            _unsubscribeToOrders(uid);
            _usersController.add(_users.values.toList());
            break;
        }
      });
    });
  }
  void _unsubscribeToOrders(String uid ){
    _users[uid]["subscription"].cancel();
  }

  void _subscribeToOrders(String uid ){
    _users[uid]["subscription"] = _firestore.collection("user").document(uid)
    .collection("orders").snapshots().listen((orders){
      int numOrders = orders.documents.length;
      double money = 0;
      orders.documents.forEach((it)async{
        DocumentSnapshot order = await _firestore.collection("orders").document(it.documentID).get();
        money += order?.data["totalPrice"];
      });
      _users[uid].addAll({
        "money":money, "orders":numOrders
      });
      _usersController.add(_users.values.toList());
    });
  }

  @override
  void dispose() {
    _usersController.close();
    super.dispose();
  }

  void onChangedSearch(String value) {
    if( value.trim().isEmpty  ){
      _usersController.add(_users.values.toList());
    }else{
      _usersController.add(_filter(value.trim()));
    }
  }

  List<Map<String,dynamic>> _filter (String search){
    List<Map<String,dynamic>> filteredUsers = List.from(_users.values.toList());
    filteredUsers.retainWhere((user){
      return user["name"].toUpperCase().contains(search.toUpperCase());
    });
    return filteredUsers;
  }

  Map<String,dynamic> getUser(String uid){
    return _users[uid];
  }
}
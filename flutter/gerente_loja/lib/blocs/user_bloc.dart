import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {
  final _userController = BehaviorSubject<List>();

  Map<String, Map<String, dynamic>> _users = {};
  Stream<List> get outUsers => _userController.stream;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserBloc() {
    _addUsersListener();
  }

  void _addUsersListener() {
    _firestore.collection('users').snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        String uid = change.doc.id;

        switch (change.type) {
          case DocumentChangeType.added:
            _users[uid] = change.doc.data();
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(change.doc.data());
            _userController.add(_users.values.toList());
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            _unsubscriptionToOrders(uid);
            _userController.add(_users.values.toList());
            break;
        }
      });
    });
  }

  void _subscribeToOrders(String uid) {
    _users[uid]['subscription'] = _firestore
        .collection('users')
        .doc(uid)
        .collection('orders')
        .snapshots()
        .listen((orders) async {
      int numOrders = orders.docs.length;
      double money = 0.0;
      for (DocumentSnapshot doc in orders.docs) {
        DocumentSnapshot order =
            await _firestore.collection('orders').doc(doc.id).get();

        if (order.data() == null) continue;

        money += order.data()['totalPrice'];
        _users[uid].addAll({"money": money, "orders": numOrders});
        _userController.add(_users.values.toList());
      }
    });
  }

  void onChangedSearch(String search) {
    if (search.trim().isEmpty) {
      _userController.add(_users.values.toList());
    } else {
      _userController.add(_filter(search.trim()));
    }
  }

  List<Map<String, dynamic>> _filter(String search) {
    List<Map<String, dynamic>> filteredUsers =
        List.from(_users.values.toList());

    filteredUsers.retainWhere((user) {
      return user['name'].toUpperCase().contains(search.toUpperCase());
    });
    return filteredUsers;
  }

  void _unsubscriptionToOrders(String uid) {
    _users[uid]['subscription'].cancel();
  }

  Map<String, dynamic> getUser(String uid) {
    return _users[uid];
  }

  @override
  void dispose() {
    super.dispose();
    _userController.close();
  }
}

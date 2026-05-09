import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

enum SortCriteria { ReadFirst, ReadLast }

class OrdersBloc extends BlocBase {
  final _ordersController = BehaviorSubject<List>();

  Stream<List> get outOrders => _ordersController.stream;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<DocumentSnapshot> _orders = [];

  SortCriteria _criteria;

  OrdersBloc() {
    _addOrdersListener();
  }

  void _addOrdersListener() {
    _firestore.collection('orders').snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        String uid = change.doc.id;

        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(change.doc);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((doc) => doc.id == uid);
            _orders.add(change.doc);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((doc) => doc.id == uid);
            break;
        }
      });

      _sort();
    });
  }

  void setOrderCriteria(SortCriteria criteria) {
    _criteria = criteria;
    _sort();
  }

  void _sort() {
    switch (_criteria) {
      case SortCriteria.ReadFirst:
        _orders.sort((a, b) {
          int statusA = a.data()['status'];
          int statusB = b.data()['status'];

          if (statusA < statusB)
            return 1;
          else if (statusA > statusB)
            return -1;
          else
            return 0;
        });
        break;
      case SortCriteria.ReadLast:
        _orders.sort((a, b) {
          int statusA = a.data()['status'];
          int statusB = b.data()['status'];

          if (statusA > statusB)
            return 1;
          else if (statusA < statusB)
            return -1;
          else
            return 0;
        });
        break;
    }
    _ordersController.add(_orders);
  }

  @override
  void dispose() {
    super.dispose();
    _ordersController.close();
  }
}

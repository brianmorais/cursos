import 'package:xlo_mobx/models/address.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/models/user.dart';

enum AdStatus { PENDING, ACTIVE, SOLD, DELETED }

class Ad {
  late String id;
  late List images;
  late String title;
  late String description;
  late Category? category;
  late Address? address;
  late num? price;
  late bool? hidePhone;
  AdStatus status = AdStatus.PENDING;
  late DateTime created;
  late User? user;
  late int views;
}

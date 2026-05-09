import 'package:animation/screens/home/widgets/list_data.dart';
import 'package:flutter/material.dart';

class AnimatedListView extends StatelessWidget {
  final Animation<EdgeInsets> listSidePosition;
  AnimatedListView({@required this.listSidePosition});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ListData(
          title: 'Estudar',
          subtitle: 'Flutter',
          image: AssetImage('images/perfil.png'),
          margin: listSidePosition.value * 1,
        ),
        ListData(
          title: 'Estudar 2',
          subtitle: 'Flutter 2',
          image: AssetImage('images/perfil.png'),
          margin: listSidePosition.value * 2,
        ),
      ],
    );
  }
}

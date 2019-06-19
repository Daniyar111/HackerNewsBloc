import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        ListTile(
          title: _buildContainer(),
          subtitle: _buildContainer(),
        ),
        Divider(height: 8,)
      ],
    );
  }


  Widget _buildContainer(){
    return Container(
      color: Colors.grey[200],
      height: 24,
      width: 150,
      margin: EdgeInsets.only(top: 5, bottom: 5),
    );
  }
}

import 'package:flutter/material.dart';

class NothingToShow extends StatelessWidget {
  const NothingToShow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const <Widget>[
            Center(
              child: Icon(
                Icons.info_outline,
                size: 200,
              ),
            ),
            Text(
              'Nothing to show!',
              style: TextStyle(fontSize: 80),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

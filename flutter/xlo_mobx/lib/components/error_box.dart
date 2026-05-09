import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return message == ''
        ? Container()
        : Container(
            padding: const EdgeInsets.all(8),
            color: Colors.red,
            child: Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    '$message. Por favor, tente novamente.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

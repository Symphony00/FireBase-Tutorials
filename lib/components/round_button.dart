import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/loading_provider.dart';

class RoundButton extends StatelessWidget {
  final String buttonText;
  VoidCallback onPress;
  RoundButton({super.key, required this.buttonText, required this.onPress});

  @override
  Widget build(BuildContext context) {
    final loadingObj = Provider.of<LoadingProvider>(context);

    return InkWell(
      onTap: onPress,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.purple),
        child: Center(
            child: loadingObj.loading
                ? CircularProgressIndicator(
                    color: Colors.amber[400],
                  )
                : Text(
                    buttonText,
                    style: const TextStyle(color: Colors.white),
                  )),
      ),
    );
  }
}

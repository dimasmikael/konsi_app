import 'package:flutter/material.dart';

class LoadingWidget {
  openLoadingDialog(BuildContext context, String textLoading) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const CircularProgressIndicator(),
              const SizedBox(
                height: 20,
              ),
              Text(textLoading)
            ],
          ),
        );
      },
    );
  }

  loadingWithText() {
    return Center(
      child: Column(
        children: const <Widget>[
          Text("Carregando endereços"),
          CircularProgressIndicator(
            color: Colors.orangeAccent,
          )
        ],
      ),
    );
  }
}

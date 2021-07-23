import 'package:flutter/material.dart';

class Loader {
  BuildContext _context;

  void hide() {
    Navigator.of(_context, rootNavigator: true).pop();
  }

  void show() {
    showDialog(
      context: _context,
      barrierDismissible: false,
      builder: (context) => _FullScreenLoader(
        ctx: _context,
      ),
    );
  }

  Future<T> during<T>(Future<T> future) {
    show();
    return future.whenComplete(
      () => hide(),
    );
  }

  Loader._create(this._context);

  factory Loader.of(BuildContext context) {
    return Loader._create(context);
  }
}

class _FullScreenLoader extends StatelessWidget {
  final BuildContext? ctx;
  _FullScreenLoader({this.ctx});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 0.5),
        ),
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(ctx ?? context).accentColor),
          ),
        ),
      ),
    );
  }
}

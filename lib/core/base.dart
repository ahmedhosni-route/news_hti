import 'package:flutter/material.dart';

abstract class BaseConnector {
  void showLoading();
  void hideLoading();
}

class BaseViewModel<T extends BaseConnector> extends ChangeNotifier {
  T? connector;
}

abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseConnector {
  late VM viewModel;
  @override
  void initState() {
    viewModel = initViewModel();
    super.initState();
  }

  VM initViewModel();

  @override
  void hideLoading() {
    Navigator.pop(context);
  }

  @override
  void showLoading() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

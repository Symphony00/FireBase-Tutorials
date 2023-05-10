import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoadingProvider with ChangeNotifier {
  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
}

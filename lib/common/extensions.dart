import 'package:flutter/material.dart';
import 'package:http/http.dart';

extension SuccessCheck on Response {
  bool isSuccess() {
    return statusCode >= 200 && statusCode < 300;
  }
}

typedef ViewModel = ChangeNotifier;
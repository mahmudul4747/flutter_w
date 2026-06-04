import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_w/Age_Calculator/features/age_Calculator/data/model/age_model.dart';


import '../repository/age_repository.dart';

class AgeProvider extends ChangeNotifier {

  final AgeRepository repository =
      AgeRepository();

  DateTime? dob;
  AgeModel? age;

  Timer? _timer;

  void setDob(DateTime date) {
    dob = date;
    _startLiveUpdate();
  }

  void _startLiveUpdate() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (dob != null) {
          age = repository.getAge(dob!);
          notifyListeners();
        }
      },
    );
  }

  void stop() {
    _timer?.cancel();
  }
}
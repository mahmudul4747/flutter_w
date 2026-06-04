import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_w/Age_Calculator/features/age_Calculator/data/model/age_model.dart';
import 'package:flutter_w/Age_Calculator/features/age_Calculator/repository/age_repository.dart';



class AgeProvider extends ChangeNotifier {

  final AgeRepository repo =
      AgeRepository();

  AgeModel? age;
  DateTime? dob;

  Timer? _timer;

  void setDob(DateTime date) {

    dob = date;

    _startLive();
  }

  void _startLive() {

    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {

        if (dob != null) {

          age = repo.getAge(dob!);

          notifyListeners();
        }
      },
    );
  }

  String getShareText() {

    if (age == null) return "";

    return """
🎂 Age Calculator Result

Years: ${age!.years}
Months: ${age!.months}
Days: ${age!.days}

Total Days: ${age!.totalDays}
Total Hours: ${age!.totalHours}
Total Minutes: ${age!.totalMinutes}

Zodiac: ${age!.zodiac}
Next Birthday: ${age!.nextBirthday}
""";
  }

  @override
  void dispose() {

    _timer?.cancel();

    super.dispose();
  }
}
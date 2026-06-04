import 'package:flutter_w/Age_Calculator/core/utils/zodiac_utils.dart';
import 'package:flutter_w/Age_Calculator/features/age_Calculator/data/model/age_model.dart';



class AgeService {

  AgeModel calculate(DateTime birthDate) {

    DateTime now = DateTime.now();

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;

    if (days < 0) {
      months--;
      DateTime prevMonth =
          DateTime(now.year, now.month, 0);
      days += prevMonth.day;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    Duration diff = now.difference(birthDate);

    // next birthday
    DateTime nextBirthday = DateTime(
      now.year,
      birthDate.month,
      birthDate.day,
    );

    if (nextBirthday.isBefore(now)) {
      nextBirthday = DateTime(
        now.year + 1,
        birthDate.month,
        birthDate.day,
      );
    }

    Duration birthdayDiff =
        nextBirthday.difference(now);

    return AgeModel(
      years: years,
      months: months,
      days: days,
      totalDays: diff.inDays,
      totalHours: diff.inHours,
      totalMinutes: diff.inMinutes,
      totalSeconds: diff.inSeconds,
      zodiac: ZodiacUtils.getZodiac(
        birthDate.day,
        birthDate.month,
      ),
      nextBirthday:
          "${birthdayDiff.inDays} Days Left",
    );
  }
}
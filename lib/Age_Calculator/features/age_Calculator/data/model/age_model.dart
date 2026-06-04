class AgeModel {

  final int years;
  final int months;
  final int days;

  final int totalDays;
  final int totalHours;
  final int totalMinutes;
  final int totalSeconds;

  final String zodiac;

  final String nextBirthday;

  AgeModel({
    required this.years,
    required this.months,
    required this.days,
    required this.totalDays,
    required this.totalHours,
    required this.totalMinutes,
    required this.totalSeconds,
    required this.zodiac,
    required this.nextBirthday,
  });
}
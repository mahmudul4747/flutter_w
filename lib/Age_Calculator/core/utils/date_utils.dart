class DateUtilsHelper {

  static String formatCountdown(Duration duration) {

    int days = duration.inDays;

    int hours =
        duration.inHours.remainder(24);

    int minutes =
        duration.inMinutes.remainder(60);

    return "$days Days $hours Hours $minutes Minutes";
  }
}
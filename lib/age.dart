import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgeHome extends StatefulWidget {
  const AgeHome({super.key});

  @override
  State<AgeHome> createState() => _AgeHomeState();
}

class _AgeHomeState extends State<AgeHome> {
  DateTime? birthDate;
  Timer? timer;

  int years = 0;
  int months = 0;
  int days = 0;

  int totalDays = 0;
  int totalHours = 0;
  int totalMinutes = 0;
  int totalSeconds = 0;

  String nextBirthday = "--";
  String zodiac = "--";

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> pickBirthDate() async {
    DateTime now = DateTime.now();

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    birthDate = picked;
    calculateAge();

    timer?.cancel();
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        calculateAge();
      },
    );
    }

  void calculateAge() {
    if (birthDate == null) return;

    DateTime now = DateTime.now();

    int y = now.year - birthDate!.year;
    int m = now.month - birthDate!.month;
    int d = now.day - birthDate!.day;

    if (d < 0) {
      m--;
      DateTime previousMonth =
          DateTime(now.year, now.month, 0);
      d += previousMonth.day;
    }

    if (m < 0) {
      y--;
      m += 12;
    }

    Duration diff = now.difference(birthDate!);

    DateTime upcomingBirthday =
        DateTime(now.year, birthDate!.month, birthDate!.day);

    if (upcomingBirthday.isBefore(now)) {
      upcomingBirthday =
          DateTime(now.year + 1, birthDate!.month, birthDate!.day);
    }

    Duration birthdayDiff =
        upcomingBirthday.difference(now);

    setState(() {
      years = y;
      months = m;
      days = d;

      totalDays = diff.inDays;
      totalHours = diff.inHours;
      totalMinutes = diff.inMinutes;
      totalSeconds = diff.inSeconds;

      nextBirthday =
          "${birthdayDiff.inDays} Days Remaining";

      zodiac = getZodiac(
        birthDate!.day,
        birthDate!.month,
      );
    });
  }

  String getZodiac(int day, int month) {
    if ((month == 3 && day >= 21) ||
        (month == 4 && day <= 19)) {
      return "Aries";
    } else if ((month == 4 && day >= 20) ||
        (month == 5 && day <= 20)) {
      return "Taurus";
    } else if ((month == 5 && day >= 21) ||
        (month == 6 && day <= 20)) {
      return "Gemini";
    } else if ((month == 6 && day >= 21) ||
        (month == 7 && day <= 22)) {
      return "Cancer";
    } else if ((month == 7 && day >= 23) ||
        (month == 8 && day <= 22)) {
      return "Leo";
    } else if ((month == 8 && day >= 23) ||
        (month == 9 && day <= 22)) {
      return "Virgo";
    } else if ((month == 9 && day >= 23) ||
        (month == 10 && day <= 22)) {
      return "Libra";
    } else if ((month == 10 && day >= 23) ||
        (month == 11 && day <= 21)) {
      return "Scorpio";
    } else if ((month == 11 && day >= 22) ||
        (month == 12 && day <= 21)) {
      return "Sagittarius";
    } else if ((month == 12 && day >= 22) ||
        (month == 1 && day <= 19)) {
      return "Capricorn";
    } else if ((month == 1 && day >= 20) ||
        (month == 2 && day <= 18)) {
      return "Aquarius";
    } else {
      return "Pisces";
    }
  }

  Widget ageCard(
      String title,
      String value,
      IconData icon,
      ) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Icon(icon, size: 30),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoTile(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String dobText = birthDate == null
        ? "Select Date of Birth"
        : DateFormat("dd MMM yyyy").format(birthDate!);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Premium Age Calculator"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              elevation: 5,
              child: ListTile(
                leading: const Icon(Icons.cake),
                title: Text(dobText),
                trailing: ElevatedButton(
                  onPressed: pickBirthDate,
                  child: const Text("Pick"),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                ageCard(
                    "Years",
                    years.toString(),
                    Icons.calendar_today),
                ageCard(
                    "Months",
                    months.toString(),
                    Icons.date_range),
                ageCard(
                    "Days",
                    days.toString(),
                    Icons.today),
              ],
            ),

            const SizedBox(height: 20),

            infoTile(
                "Total Days",
                totalDays.toString()),
            infoTile(
                "Total Hours",
                totalHours.toString()),
            infoTile(
                "Total Minutes",
                totalMinutes.toString()),
            infoTile(
                "Total Seconds",
                totalSeconds.toString()),

            const SizedBox(height: 15),

            infoTile(
                "Next Birthday",
                nextBirthday),

            infoTile(
                "Zodiac Sign",
                zodiac),

            const SizedBox(height: 20),

            const Icon(
              Icons.celebration,
              size: 80,
            ),

            const Text(
              "Play Store Ready Age Calculator",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
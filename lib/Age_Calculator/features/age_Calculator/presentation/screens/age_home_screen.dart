import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../widgets/age_card.dart';
import '../widgets/info_tile.dart';
import '../widgets/birthday_countdown.dart';
import '../widgets/zodiac_card.dart';
import '../widgets/gradient_header.dart';

import '../../provider/age_provider.dart';
import '../../data/services/share_service.dart';
import '../../data/services/firebase_service.dart';
import '../../data/model/history_model.dart';

class AgeHomeScreen extends StatelessWidget {
  const AgeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<AgeProvider>(context);

   // final firebase = FirebaseService();

    return Column(
      children: [

        // HEADER
        const GradientHeader(
          title: "Premium Age Calculator",
          subtitle: "Calculate your exact age instantly",
        ),

        const SizedBox(height: 10),

        // LOTTIE (safe)
        Lottie.asset(
  "assets/animations/age_animation.json",
          height: 120,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.cake,
              size: 100,
            );
          },
        ),

        const SizedBox(height: 10),

        // DOB PICKER
        ElevatedButton.icon(
          onPressed: () async {
  DateTime? picked = await showDatePicker(
    context: context,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    initialDate: DateTime(2000),
  );

  if (picked == null) return;

  provider.setDob(picked);
},
          icon: const Icon(Icons.cake),
          label: const Text("Select DOB"),
        ),

        const SizedBox(height: 10),

        // SHARE + SAVE
       ElevatedButton.icon(
  onPressed: (provider.age == null || provider.dob == null)
      ? null
      : () {
          ShareService.shareResult(provider.getShareText());
        },
  icon: const Icon(Icons.share),
  label: const Text("Share & Save"),
),

        const SizedBox(height: 10),

        // BODY
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [

                if (provider.age != null) ...[

                 Row(
                    children: [

                      Expanded(
                        child: AgeCard(
                          title: "Years",
                          value: provider.age!.years.toString(),
                          icon: Icons.calendar_today,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: AgeCard(
                          title: "Months",
                          value: provider.age!.months.toString(),
                          icon: Icons.date_range,
                        ),
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: AgeCard(
                          title: "Days",
                          value: provider.age!.days.toString(),
                          icon: Icons.today,
                        ),
                      ),
                    ],
                  ),

                  InfoTile(
                    title: "Total Days",
                    value: provider.age!.totalDays.toString(),
                  ),

                  InfoTile(
                    title: "Total Hours",
                    value: provider.age!.totalHours.toString(),
                  ),

                  InfoTile(
                    title: "Total Minutes",
                    value: provider.age!.totalMinutes.toString(),
                  ),

                  InfoTile(
                    title: "Total Seconds",
                    value: provider.age!.totalSeconds.toString(),
                  ),

                  BirthdayCountdown(
                    value: provider.age!.nextBirthday,
                  ),

                  ZodiacCard(
                    zodiac: provider.age!.zodiac,
                  ),
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }
}
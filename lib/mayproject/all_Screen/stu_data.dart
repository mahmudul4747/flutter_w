import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class StudentDetailsPage extends StatefulWidget {
  final Map<String, dynamic> student;

  const StudentDetailsPage({
    super.key,
    required this.student,
  });

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {

  bool isLoading = true;

  List<Map<String, dynamic>> skills = [];

  final Color primaryColor = const Color(0xFF6C63FF);

  @override
  void initState() {
    super.initState();
    fetchSkills();
  }

  // ================= API =================

  Future<void> fetchSkills() async {

    try {

      final response = await http.get(
        Uri.parse(
          "http://10.0.2.2/phpLG/get_skills.php",
        ),
      );

      if (response.statusCode == 200) {

        final data = jsonDecode(response.body);

        setState(() {
          skills = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      }

    } catch (e) {

      setState(() {
        isLoading = false;

        skills = [
          {"name": "Flutter", "progress": 90},
          {"name": "PHP", "progress": 75},
          {"name": "Firebase", "progress": 80},
          {"name": "MySQL", "progress": 85},
          {"name": "Java", "progress": 65},
        ];
      });
    }
  }

  // ================= PIE CHART =================

  Widget buildPieChart() {

    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(.15),
            Colors.white.withOpacity(.05),
          ],
        ),

        border: Border.all(
          color: Colors.white.withOpacity(.1),
        ),
      ),

      child: PieChart(
        PieChartData(

          sectionsSpace: 3,
          centerSpaceRadius: 50,

          sections: List.generate(
            skills.length,
            (index) {

              final skill = skills[index];

              return PieChartSectionData(
                value: skill['progress'].toDouble(),
                radius: 60,
                title: "${skill['progress']}%",
                titleStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ================= BAR CHART =================

  Widget buildBarChart() {

    return Container(
      height: 320,
      padding: const EdgeInsets.all(20),

      decoration: glassDecoration(),

      child: BarChart(

        swapAnimationDuration: const Duration(milliseconds: 800),

        BarChartData(

          maxY: 100,

          borderData: FlBorderData(show: false),

          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
          ),

          titlesData: FlTitlesData(

            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 20,
                reservedSize: 30,
              ),
            ),

            bottomTitles: AxisTitles(
              sideTitles: SideTitles(

                showTitles: true,

                getTitlesWidget: (value, meta) {

                  if (value.toInt() >= skills.length) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),

                    child: Text(
                      skills[value.toInt()]['name']
                          .toString()
                          .substring(0, 2),

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          barGroups: List.generate(
            skills.length,
            (index) {

              return BarChartGroupData(
                x: index,

                barRods: [

                  BarChartRodData(
                    toY: skills[index]['progress'].toDouble(),
                    width: 18,

                    borderRadius: BorderRadius.circular(10),

                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        Colors.purpleAccent,
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ================= GLASS EFFECT =================

  BoxDecoration glassDecoration() {

    return BoxDecoration(

      borderRadius: BorderRadius.circular(30),

      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(.15),
          Colors.white.withOpacity(.05),
        ],
      ),

      border: Border.all(
        color: Colors.white.withOpacity(.1),
      ),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.15),
          blurRadius: 20,
        ),
      ],
    );
  }

  // ================= ANALYTICS CARD =================

  Widget analyticsCard(
    String title,
    String value,
    IconData icon,
  ) {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: glassDecoration(),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),

          const SizedBox(height: 12),

          Text(
            value,

            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,

            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ================= MAIN UI =================

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xFF0F172A),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )

          : CustomScrollView(

              slivers: [

                // ================= APP BAR =================

                SliverAppBar(

                  expandedHeight: 300,
                  pinned: true,

                  backgroundColor: Colors.transparent,

                  flexibleSpace: FlexibleSpaceBar(

                    title: Text(
                      widget.student['name'] ?? '',

                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    background: Stack(

                      fit: StackFit.expand,

                      children: [

                        Container(

                          decoration: const BoxDecoration(

                            gradient: LinearGradient(

                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,

                              colors: [
                                Color(0xFF6C63FF),
                                Color(0xFF8E7CFF),
                                Color(0xFF2D1B69),
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          top: 80,
                          left: 0,
                          right: 0,

                          child: Hero(

                            tag: widget.student['id'] ?? "student",

                            child: const CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.white,

                              child: Icon(
                                Icons.person,
                                size: 70,
                                color: Color(0xFF6C63FF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ================= BODY =================

                SliverToBoxAdapter(

                  child: Padding(

                    padding: const EdgeInsets.all(16),

                    child: Column(

                      children: [

                        // ================= INFO =================

                        Container(

                          padding: const EdgeInsets.all(20),

                          decoration: glassDecoration(),

                          child: Column(

                            children: [

                              infoRow(
                                "Email",
                                widget.student['email'] ?? '',
                              ),

                              infoRow(
                                "Department",
                                widget.student['department'] ?? '',
                              ),

                              infoRow(
                                "Semester",
                                widget.student['semester'] ?? '',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 25),

                        // ================= ANALYTICS =================

                        GridView.count(

                          crossAxisCount:
                              MediaQuery.of(context).size.width > 700
                                  ? 4
                                  : 2,

                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,

                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(),

                          children: [

                            analyticsCard(
                              "Projects",
                              "12",
                              Icons.folder,
                            ),

                            analyticsCard(
                              "CGPA",
                              "3.89",
                              Icons.school,
                            ),

                            analyticsCard(
                              "Skills",
                              "${skills.length}",
                              Icons.analytics,
                            ),

                            analyticsCard(
                              "Ranking",
                              "#05",
                              Icons.emoji_events,
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // ================= PIE =================

                        buildPieChart(),

                        const SizedBox(height: 25),

                        // ================= BAR =================

                        buildBarChart(),

                        const SizedBox(height: 25),

                        // ================= SKILLS =================

                        ListView.builder(

                          itemCount: skills.length,

                          shrinkWrap: true,

                          physics:
                              const NeverScrollableScrollPhysics(),

                          itemBuilder: (context, index) {

                            final skill = skills[index];

                            return Container(

                              margin:
                                  const EdgeInsets.only(bottom: 15),

                              padding: const EdgeInsets.all(18),

                              decoration: glassDecoration(),

                              child: Row(

                                children: [

                                  CircleAvatar(
                                    backgroundColor:
                                        primaryColor,

                                    child: Text(
                                      skill['name']
                                          .toString()
                                          .substring(0, 1),
                                    ),
                                  ),

                                  const SizedBox(width: 15),

                                  Expanded(

                                    child: Column(

                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,

                                      children: [

                                        Text(
                                          skill['name'],

                                          style:
                                              GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeight.w600,
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        ClipRRect(

                                          borderRadius:
                                              BorderRadius.circular(
                                                  20),

                                          child:
                                              LinearProgressIndicator(

                                            minHeight: 10,

                                            value: skill['progress'] /
                                                100,

                                            backgroundColor:
                                                Colors.white12,

                                            valueColor:
                                                AlwaysStoppedAnimation(
                                              primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Text(
                                    "${skill['progress']}%",

                                    style:
                                        GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // ================= INFO ROW =================

  Widget infoRow(String title, String value) {

    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 10),

      child: Row(

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,

            style: GoogleFonts.poppins(
              color: Colors.white70,
            ),
          ),

          Text(
            value,

            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class StudentDetailsPage extends StatefulWidget {
  final Map<String, dynamic> student;

  const StudentDetailsPage({super.key, required this.student});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  double animValue = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animValue = 1;
      });
    });
  }

  final List<Map<String, dynamic>> skills = [
    {"name": "C Language", "progress": 80},
    {"name": "Java", "progress": 70},
    {"name": "Python", "progress": 60},
    {"name": "PHP", "progress": 75},
    {"name": "Dart", "progress": 90},
    {"name": "HTML", "progress": 95},
    {"name": "CSS", "progress": 85},
    {"name": "JavaScript", "progress": 65},
    {"name": "Flutter", "progress": 88},
    {"name": "Algorithm", "progress": 55},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),

      body: CustomScrollView(
        slivers: [

          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: const Color.fromARGB(214, 240, 219, 37),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.student['name'] ?? ''),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(214, 240, 219, 37),
                      Color(0xFFFFD54F),
                    ],
                  ),
                ),
                child: const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 50),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  _infoCard("Email", widget.student['email'] ?? ''),
                  _infoCard("Department", widget.student['department'] ?? 'N/A'),
                  _infoCard("Semester", widget.student['semester'] ?? 'N/A'),

                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Skill Analytics",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  ...skills.map((skill) => _skillCard(skill)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // INFO CARD
  Widget _infoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 🔥 ANIMATED SKILL CARD (SMOOTH FILL)
  Widget _skillCard(Map<String, dynamic> skill) {
    double target = (skill['progress'] ?? 0) / 100;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: animValue * target),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [

              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 55,
                    width: 55,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 6,
                      backgroundColor: Colors.grey[200],
                      color: Colors.amber,
                    ),
                  ),
                  Text("${(value * 100).toInt()}%"),
                ],
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Text(
                  skill['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
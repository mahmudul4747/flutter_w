class HistoryModel {
  final String dob;
  final String calculatedAge;
  final DateTime createdAt;

  HistoryModel({
    required this.dob,
    required this.calculatedAge,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'dob': dob,
      'calculatedAge': calculatedAge,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      dob: map['dob'] ?? '',
      calculatedAge: map['calculatedAge'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }
}
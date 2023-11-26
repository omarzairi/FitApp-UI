class ProgressWeight {
  final String id;
  final String userId;
  final List<WeightEntry> weightList;

  ProgressWeight({
    required this.id,
    required this.userId,
    required this.weightList,
  });

  factory ProgressWeight.fromJson(Map<String, dynamic> json) {
    return ProgressWeight(
      id: json['_id'],

      userId: json['user'],
      weightList: (json['listePoids'] as List<dynamic>)
          .map((entry) => WeightEntry.fromJson(entry))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': userId,
      'listePoids': weightList.map((entry) => entry.toJson()).toList(),
    };
  }
}

class WeightEntry {
  final double weight;
  final DateTime date;

  WeightEntry({
    required this.weight,
    required this.date,
  });

  factory WeightEntry.fromJson(Map<String, dynamic> json) {
    return WeightEntry(
      weight: double.parse(json['poids'].toString()),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'poids': weight,
      'date': date.toIso8601String(),
    };
  }
}

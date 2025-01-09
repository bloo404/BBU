class Entity {
  int? id;
  String date;
  String type;
  double duration;
  String priority;
  String category;
  String description;

  Entity(
      {this.id,
      required this.date,
      required this.type,
      required this.duration,
      required this.priority,
      required this.category,
      required this.description});

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      id: json['id'] as int?,
      type: json['type'] as String,
      date: json['date'] as String,
      duration: _parseDouble(json['duration']),
      priority: json['priority'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      return double.parse(value);
    } else {
      throw ArgumentError('Invalid duration format: $value');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'type': type,
      'duration': duration,
      'priority': priority,
      'category': category,
      'description': description
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'date': date,
      'type': type,
      'duration': duration,
      'priority': priority,
      'category': category,
      'description': description
    };
  }

  Entity copy(
          {int? id,
          String? date,
          String? type,
          double? duration,
          String? priority,
          String? category,
          String? description}) =>
      Entity(
          id: id ?? this.id,
          date: date ?? this.date,
          type: type ?? this.type,
          duration: duration ?? this.duration,
          priority: priority ?? this.priority,
          category: category ?? this.category,
          description: description ?? this.description);
  @override
  String toString() {
    return 'Entity - id: $id, date: $date, type: $type, duration: $duration, priority: $priority, category: $category, description: $description';
  }
}

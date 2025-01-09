class Entity {
  int? id;
  String name;
  String organizer;
  String category;
  int capacity;
  int registered;

  Entity({
    this.id,
    required this.name,
    required this.organizer,
    required this.category,
    required this.capacity,
    required this.registered,
  });

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      id: json['id'] as int?,
      name: json['name'] as String,
      organizer: json['organizer'] as String,
      category: json['category'] as String,
      capacity: json['capacity'] as int,
      registered: json['registered'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'organizer': organizer,
      'category': category,
      'capacity': capacity,
      'registered': registered
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'name': name,
      'organizer': organizer,
      'category': category,
      'capacity': capacity,
      'registered': registered
    };
  }

  Entity copy(
          {int? id,
          String? name,
          String? organizer,
          String? category,
          int? capacity,
          int? registered}) =>
      Entity(
        id: id ?? this.id,
        name: name ?? this.name,
        organizer: organizer ?? this.organizer,
        category: category ?? this.category,
        capacity: capacity ?? this.capacity,
        registered: registered ?? this.registered,
      );

  @override
  String toString() {
    return 'Event - name: $name, organizer: $organizer, category: $category, capacity: $capacity, registered: $registered';
  }
}

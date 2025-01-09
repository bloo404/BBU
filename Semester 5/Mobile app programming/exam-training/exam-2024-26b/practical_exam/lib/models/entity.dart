class Entity {
  int? id;
  String name;
  String team;
  String details;
  String status;
  int participants;
  String type;
  Entity(
      {this.id,
      required this.name,
      required this.team,
      required this.details,
      required this.status,
      required this.participants,
      required this.type});
  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
        id: json['id'] as int?,
        name: json['name'] as String,
        team: json['team'] as String,
        details: json['details'] as String,
        status: json['status'] as String,
        participants: json['participants'] as int,
        type: json['type'] as String);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'team': team,
      'details': details,
      'status': status,
      'participants': participants,
      'type': type
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'name': name,
      'team': team,
      'details': details,
      'status': status,
      'participants': participants,
      'type': type
    };
  }

  Entity copy(
          {int? id,
          String? name,
          String? team,
          String? details,
          String? status,
          int? participants,
          String? type}) =>
      Entity(
          id: id ?? this.id,
          name: name ?? this.name,
          team: team ?? this.team,
          details: details ?? this.details,
          status: status ?? this.status,
          participants: participants ?? this.participants,
          type: type ?? this.type);
  @override
  String toString() {
    return 'Entity - id: $id, name: $name, team: $team, details: $details, status: $status, participants: $participants, type: $type';
  }
}

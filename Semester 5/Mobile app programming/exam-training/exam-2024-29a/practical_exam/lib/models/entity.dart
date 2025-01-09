class Entity {
  int? id;
  String title;
  String author;
  String genre;
  int quantity;
  int reserved;

  Entity(
      {this.id,
      required this.title,
      required this.author,
      required this.genre,
      required this.quantity,
      required this.reserved});

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
        id: json['id'] as int?,
        title: json['title'] as String,
        author: json['author'] as String,
        genre: json['genre'] as String,
        quantity: json['quantity'] as int,
        reserved: json['reserved'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'quantity': quantity,
      'reserved': reserved
    };
  }

  Map<String, dynamic> toJsonWithoutId() {
    return {
      'title': title,
      'author': author,
      'genre': genre,
      'quantity': quantity,
      'reserved': reserved
    };
  }

  Entity copy(
          {int? id,
          String? title,
          String? author,
          String? genre,
          int? quantity,
          int? reserved}) =>
      Entity(
          id: id ?? this.id,
          title: title ?? this.title,
          author: author ?? this.author,
          genre: genre ?? this.genre,
          quantity: quantity ?? this.quantity,
          reserved: reserved ?? this.reserved);

  @override
  String toString() {
    return 'Book - title: $title, author: $author, genre: $genre, quantity: $quantity, reserved: $reserved';
  }
}

class Item {
  final String? id;
  final String? title;
  final String? Subtitle;
  final String? image;

  Item(
      {required this.id,
      required this.title,
      required this.Subtitle,
      required this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      Subtitle: json['subtitle'],
      image: json['image'],
    );
  }
}

class Datasummary {
  String? id;
  String? url;
  String? description;
  String? type;
  String? title;
  int? count;

  Datasummary(
      {required this.id,
      required this.url,
      required this.description,
      required this.type,
      required this.title,
      required this.count});

  factory Datasummary.fromJson(Map<String, dynamic> json) {
    return Datasummary(
      id: json['id'],
      url: json['url'],
      description: json['description'],
      type: json['type'],
      title: json['summary']['title'],
      count: json['summary']['count'],
    );
  }
}

class Exhibit {
  final String title;
  final List<dynamic> images;

  Exhibit({required this.title, required this.images});

  factory Exhibit.fromJson(Map<String, dynamic> json) {
    return Exhibit(title: json['title'], images: json['images']);
  }
}

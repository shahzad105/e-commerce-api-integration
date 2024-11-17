class Item {
  final int id;
  final String name;
  final String description;
  final int price;
  final String thumbnail; // Add thumbnail field
  final String title; // Add title field

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.thumbnail, // Initialize thumbnail
    required this.title, // Initialize title
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      thumbnail: json['thumbnail'] ?? '', // Default to empty string if null
      title: json['title'] ?? json['name'], // Default to name if title is null
    );
  }
}

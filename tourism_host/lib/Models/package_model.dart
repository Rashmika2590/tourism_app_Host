class Package {
  final String id;
  final String propertyId;
  final String name;
  final double price;
  final String description;
  final String schedule;
  final String specialFeatures;
  final List<String> images;

  Package({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.price,
    required this.description,
    required this.schedule,
    required this.specialFeatures,
    required this.images,
  });

  // Convert a Package instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'propertyId': propertyId,
      'name': name,
      'price': price,
      'description': description,
      'schedule': schedule,
      'specialFeatures': specialFeatures,
      'images': images,
    };
  }

  // Create a Package instance from a Map
  factory Package.fromMap(Map<String, dynamic> map, String id) {
    return Package(
      id: id,
      propertyId: map['propertyId'],
      name: map['name'],
      price: map['price'].toDouble(),
      description: map['description'],
      schedule: map['schedule'],
      specialFeatures: map['specialFeatures'],
      images: List<String>.from(map['images']),
    );
  }
}

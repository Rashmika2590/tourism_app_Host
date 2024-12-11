class Property {
  static const List<String> predefinedTypes = [
    'Apartment',
    'House',
    'Villa',
    'Cottage',
    'Studio'
  ];
  
  static const List<String> predefinedAmenities = [
    'WiFi',
    'Air Conditioning',
    'Swimming Pool',
    'Parking',
    'Gym'
  ];

  static const List<String> predefinedGuestTypes = [
    'Solo Travelers',
    'Couples',
    'Families',
    'Groups'
  ];

  static const List<String> predefinedRules = [
    'No Smoking',
    'No Pets',
    'No Parties',
    'Check-in after 2 PM',
    'Check-out before 11 AM'
  ];

  final String id;
  final String ownerId;
  final String name;
  final String description;
  final String type;
  final List<String> amenities;
  final List<String> guestTypes;
  final List<String> rules;
  final int noOfBathrooms;
  final int noOfBeds;
  final int noOfRooms;
  final int maxGuests;
  final String address;
  final List<String> photos;
  final List<String> packages;

  Property({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.description,
    required this.type,
    required this.amenities,
    required this.guestTypes,
    required this.rules,
    required this.noOfBathrooms,
    required this.noOfBeds,
    required this.noOfRooms,
    required this.maxGuests,
    required this.address,
    required this.photos,
    required this.packages,
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'name': name,
      'description': description,
      'type': type,
      'amenities': amenities,
      'guestTypes': guestTypes,
      'rules': rules,
      'noOfBathrooms': noOfBathrooms,
      'noOfBeds': noOfBeds,
      'noOfRooms': noOfRooms,
      'maxGuests': maxGuests,
      'address': address,
      'photos': photos,
      'packages': packages,
    };
  }

  factory Property.fromMap(Map<String, dynamic> map, String id) {
    return Property(
      id: id,
      ownerId: map['ownerId'],
      name: map['name'],
      description: map['description'],
      type: map['type'],
      amenities: List<String>.from(map['amenities']),
      guestTypes: List<String>.from(map['guestTypes']),
      rules: List<String>.from(map['rules']),
      noOfBathrooms: map['noOfBathrooms'],
      noOfBeds: map['noOfBeds'],
      noOfRooms: map['noOfRooms'],
      maxGuests: map['maxGuests'],
      address: map['address'],
      photos: List<String>.from(map['photos']),
      packages: List<String>.from(map['packages']),
    );
  }
}

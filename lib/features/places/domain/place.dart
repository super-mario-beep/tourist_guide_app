class Place {
  const Place({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final String description;
  final String address;
  final double latitude;
  final double longitude;
  final int rating;
  final String imageUrl;
}

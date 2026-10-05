import 'package:tourist_guide_app/features/places/domain/place.dart';

/// Shape of one sight as returned by `GET /sight/all`.
class PlaceDto {
  const PlaceDto({
    required this.id,
    required this.title,
    required this.description,
    required this.address,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.imageUrl,
  });

  factory PlaceDto.fromJson(Map<String, dynamic> json) {
    return PlaceDto(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      address: json['address'] as String? ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      rating: (json['rating'] as num?)?.round() ?? 0,
      imageUrl: json['imageUrl'] as String? ?? '',
    );
  }

  final int id;
  final String title;
  final String description;
  final String address;
  final double lat;
  final double lng;
  final int rating;
  final String imageUrl;

  Place toDomain() {
    return Place(
      id: id,
      name: title,
      description: description,
      address: address,
      latitude: lat,
      longitude: lng,
      rating: rating,
      imageUrl: imageUrl,
    );
  }
}

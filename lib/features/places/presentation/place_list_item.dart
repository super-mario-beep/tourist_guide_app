import 'package:flutter/material.dart';
import 'package:tourist_guide_app/core/widgets/place_card.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';
import 'package:tourist_guide_app/features/places/presentation/place_details_screen.dart';

class PlaceListItem extends StatelessWidget {
  const PlaceListItem({
    super.key,
    required this.place,
    required this.listName,
    required this.isFavorite,
    required this.onFavoritePressed,
  });

  final Place place;

  final String listName;

  final bool isFavorite;
  final VoidCallback onFavoritePressed;

  @override
  Widget build(BuildContext context) {
    final heroTag = '$listName-place-image-${place.id}';

    return PlaceCard(
      name: place.name,
      address: place.address,
      latitude: place.latitude,
      longitude: place.longitude,
      rating: place.rating,
      imageUrl: place.imageUrl,
      isFavorite: isFavorite,
      onFavoritePressed: onFavoritePressed,
      heroTag: heroTag,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) =>
              PlaceDetailsScreen(placeId: place.id, heroTag: heroTag),
        ),
      ),
    );
  }
}

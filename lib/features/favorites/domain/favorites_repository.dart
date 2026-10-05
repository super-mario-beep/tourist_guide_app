import 'package:tourist_guide_app/features/places/domain/place.dart';

/// Favorites are kept on the device so they work offline.
abstract interface class FavoritesRepository {
  List<Place> getAll();

  Place? getById(int placeId);

  bool isFavorite(int placeId);

  Future<void> toggle(Place place);

  /// Emits the current favorites right away, then again after every change.
  Stream<List<Place>> watchAll();
}

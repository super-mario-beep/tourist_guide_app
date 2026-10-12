import 'package:tourist_guide_app/features/places/domain/place.dart';

abstract interface class FavoritesRepository {
  List<Place> getAll();

  Place? getById(int placeId);

  bool isFavorite(int placeId);

  Future<void> toggle(Place place);

  Stream<List<Place>> watchAll();
}

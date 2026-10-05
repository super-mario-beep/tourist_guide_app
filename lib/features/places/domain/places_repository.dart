import 'package:tourist_guide_app/features/places/domain/place.dart';

abstract interface class PlacesRepository {
  /// Fetches places from the API and saves them to the local database.
  Future<List<Place>> getPlaces();

  /// Reads a place from the local database, saved by [getPlaces].
  Place? getSavedPlace(int id);
}

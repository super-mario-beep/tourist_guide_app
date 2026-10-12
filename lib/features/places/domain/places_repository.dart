import 'package:tourist_guide_app/features/places/domain/place.dart';

abstract interface class PlacesRepository {
  Future<List<Place>> getPlaces();

  Place? getSavedPlace(int id);
}

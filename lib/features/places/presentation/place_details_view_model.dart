import 'package:flutter/foundation.dart';
import 'package:tourist_guide_app/core/services/maps_launcher.dart';
import 'package:tourist_guide_app/features/favorites/domain/favorites_repository.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';
import 'package:tourist_guide_app/features/places/domain/places_repository.dart';

class PlaceDetailsViewModel extends ChangeNotifier {
  PlaceDetailsViewModel(
    int placeId,
    PlacesRepository placesRepository,
    this._favoritesRepository,
    this._mapsLauncher,
  ) : // Read from the local database the list saved after the API call.
      place = placesRepository.getSavedPlace(placeId);

  final FavoritesRepository _favoritesRepository;
  final MapsLauncher _mapsLauncher;

  final Place? place;

  bool get isFavorite =>
      place != null && _favoritesRepository.isFavorite(place!.id);

  void toggleFavorite() {
    if (place == null) return;
    _favoritesRepository.toggle(place!.id);
    notifyListeners();
  }

  /// Returns false when no app could open the location.
  Future<bool> openInMaps() {
    final place = this.place!;
    return _mapsLauncher.open(
      latitude: place.latitude,
      longitude: place.longitude,
      label: place.name,
    );
  }
}

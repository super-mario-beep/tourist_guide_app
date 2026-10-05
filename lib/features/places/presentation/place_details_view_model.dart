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
  ) : // Read from the local database: the places saved after the API call,
      // or the favorites, which stay saved even if the API dropped the place.
      place =
          placesRepository.getSavedPlace(placeId) ??
          _favoritesRepository.getById(placeId);

  final FavoritesRepository _favoritesRepository;
  final MapsLauncher _mapsLauncher;

  final Place? place;

  bool get isFavorite =>
      place != null && _favoritesRepository.isFavorite(place!.id);

  Future<void> toggleFavorite() async {
    if (place == null) return;
    await _favoritesRepository.toggle(place!);
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

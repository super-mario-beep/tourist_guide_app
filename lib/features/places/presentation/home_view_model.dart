import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tourist_guide_app/features/favorites/domain/favorites_repository.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';
import 'package:tourist_guide_app/features/places/domain/places_repository.dart';

enum HomeStatus { loading, error, empty, success }

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._placesRepository, this._favoritesRepository) {
    // Redraw hearts when favorites change on any screen.
    _favoritesSubscription = _favoritesRepository.watchAll().listen(
      (_) => notifyListeners(),
    );
  }

  final PlacesRepository _placesRepository;
  final FavoritesRepository _favoritesRepository;
  late final StreamSubscription<List<Place>> _favoritesSubscription;

  HomeStatus status = HomeStatus.loading;
  List<Place> places = [];

  bool isFavorite(Place place) => _favoritesRepository.isFavorite(place.id);

  void toggleFavorite(Place place) => _favoritesRepository.toggle(place);

  /// [showLoading] is false for pull-to-refresh, which has its own indicator.
  Future<void> loadPlaces({bool showLoading = true}) async {
    if (showLoading) {
      status = HomeStatus.loading;
      notifyListeners();
    }

    try {
      places = await _placesRepository.getPlaces();
      status = places.isEmpty ? HomeStatus.empty : HomeStatus.success;
    } catch (e) {
      debugPrint('Loading places failed: $e');
      status = HomeStatus.error;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _favoritesSubscription.cancel();
    super.dispose();
  }
}

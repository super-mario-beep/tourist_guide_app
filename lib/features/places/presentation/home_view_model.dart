import 'package:flutter/foundation.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';
import 'package:tourist_guide_app/features/places/domain/places_repository.dart';

enum HomeStatus { loading, error, empty, success }

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._placesRepository);

  final PlacesRepository _placesRepository;

  HomeStatus status = HomeStatus.loading;
  List<Place> places = [];

  // Kept in memory for now; local storage comes with the Favorites feature.
  final Set<int> _favoriteIds = {};

  bool isFavorite(Place place) => _favoriteIds.contains(place.id);

  void toggleFavorite(Place place) {
    if (!_favoriteIds.remove(place.id)) _favoriteIds.add(place.id);
    notifyListeners();
  }

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
}

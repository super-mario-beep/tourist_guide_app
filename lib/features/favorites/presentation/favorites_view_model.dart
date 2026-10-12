import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tourist_guide_app/features/favorites/domain/favorites_repository.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';

class FavoritesViewModel extends ChangeNotifier {
  FavoritesViewModel(this._favoritesRepository) {
    _subscription = _favoritesRepository.watchAll().listen((favorites) {
      this.favorites = favorites;
      notifyListeners();
    });
  }

  final FavoritesRepository _favoritesRepository;
  late final StreamSubscription<List<Place>> _subscription;

  List<Place> favorites = [];

  void removeFavorite(Place place) => _favoritesRepository.toggle(place);

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

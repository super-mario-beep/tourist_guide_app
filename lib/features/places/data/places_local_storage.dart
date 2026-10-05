import 'package:hive_ce/hive_ce.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';

/// Hive box holding the places from the last successful API response.
class PlacesLocalStorage {
  PlacesLocalStorage(this._box);

  static const boxName = 'places';

  final Box<Place> _box;

  /// Replaces everything stored with [places], keyed by place id.
  Future<void> saveAll(List<Place> places) async {
    await _box.clear();
    await _box.putAll({for (final place in places) place.id: place});
  }

  Place? getById(int id) => _box.get(id);
}

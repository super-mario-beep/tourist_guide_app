import 'package:hive_ce/hive_ce.dart';
import 'package:tourist_guide_app/features/favorites/domain/favorites_repository.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';

class HiveFavoritesRepository implements FavoritesRepository {
  HiveFavoritesRepository(this._box);

  static const boxName = 'favorites';

  final Box<Place> _box;

  @override
  List<Place> getAll() => _box.values.toList();

  @override
  Place? getById(int placeId) => _box.get(placeId);

  @override
  bool isFavorite(int placeId) => _box.containsKey(placeId);

  @override
  Future<void> toggle(Place place) {
    return isFavorite(place.id) ? _box.delete(place.id) : _box.put(place.id, place);
  }

  @override
  Stream<List<Place>> watchAll() async* {
    yield getAll();
    await for (final _ in _box.watch()) {
      yield getAll();
    }
  }
}

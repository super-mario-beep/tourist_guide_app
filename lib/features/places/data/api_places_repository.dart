import 'package:tourist_guide_app/features/places/data/places_api.dart';
import 'package:tourist_guide_app/features/places/data/places_local_storage.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';
import 'package:tourist_guide_app/features/places/domain/places_repository.dart';

class ApiPlacesRepository implements PlacesRepository {
  ApiPlacesRepository(this._api, this._localStorage);

  final PlacesApi _api;
  final PlacesLocalStorage _localStorage;

  @override
  Future<List<Place>> getPlaces() async {
    final dtos = await _api.getPlaces();
    final places = dtos.map((dto) => dto.toDomain()).toList();
    await _localStorage.saveAll(places);
    return places;
  }

  @override
  Place? getSavedPlace(int id) => _localStorage.getById(id);
}

import 'package:tourist_guide_app/features/places/data/places_api.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';
import 'package:tourist_guide_app/features/places/domain/places_repository.dart';

class ApiPlacesRepository implements PlacesRepository {
  ApiPlacesRepository(this._api);

  final PlacesApi _api;

  @override
  Future<List<Place>> getPlaces() async {
    final dtos = await _api.getPlaces();
    return dtos.map((dto) => dto.toDomain()).toList();
  }
}

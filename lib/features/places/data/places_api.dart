import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tourist_guide_app/features/places/data/place_dto.dart';

part 'places_api.g.dart';

@RestApi()
abstract class PlacesApi {
  factory PlacesApi(Dio dio) = _PlacesApi;

  @GET('/sight/all')
  Future<List<PlaceDto>> getPlaces();
}

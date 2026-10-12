import 'package:hive_ce/hive_ce.dart';
import 'package:tourist_guide_app/features/places/domain/place.dart';

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 0;

  @override
  Place read(BinaryReader reader) {
    return Place(
      id: reader.readInt(),
      name: reader.readString(),
      description: reader.readString(),
      address: reader.readString(),
      latitude: reader.readDouble(),
      longitude: reader.readDouble(),
      rating: reader.readInt(),
      imageUrl: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeInt(obj.id)
      ..writeString(obj.name)
      ..writeString(obj.description)
      ..writeString(obj.address)
      ..writeDouble(obj.latitude)
      ..writeDouble(obj.longitude)
      ..writeInt(obj.rating)
      ..writeString(obj.imageUrl);
  }
}

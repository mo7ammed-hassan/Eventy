import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

class CreateEventEntity {
  final String? name;
  final String? description;
  final String? category;
  final LocationEntity? location;
  final String? image;
  final String? coverImage;
  final String? isRecurring;
  final DateTime? date;
  final String? time;
  final String? price;
  final String? type;
  final bool isPaid;
  final String? host;
  final List<dynamic>? attendees;

  CreateEventEntity({
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    required this.image,
    required this.coverImage,
    required this.isRecurring,
    required this.date,
    required this.time,
    required this.price,
    required this.type,
    required this.isPaid,
    required this.host,
    required this.attendees,
  });

  static CreateEventEntity empty() => CreateEventEntity(
    name: '',
    description: '',
    category: '',
    location: LocationEntity.empty(),
    image: '',
    coverImage: '',
    isRecurring: '',
    date: DateTime.now(),
    time: '',
    price: '',
    type: '',
    host: '',
    isPaid: false,
    attendees: [],
  );
}

import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

class CreateEventEntity {
  final String? name;
  final String? description;
  final String? category;
  final LocationEntity? location;
  final String? status;
  final String? image;
  final String? coverImage;
  final String? isRecurring;
  final DateTime? date;
  final String? time;
  final String? price;
  final String? type;
  final bool? paid;
  final String? host;
  final List<dynamic>? attendees;
  final int? iV;
  final DateTime? formatedDate;
  final String? id;

  CreateEventEntity({
    required this.name,
    required this.description,
    required this.category,
    required this.location,
    required this.status,
    required this.image,
    required this.coverImage,
    required this.isRecurring,
    required this.date,
    required this.time,
    required this.price,
    required this.type,
    required this.paid,
    required this.host,
    required this.attendees,
    required this.iV,
    required this.formatedDate,
    required this.id,
  });
}

import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

class EventEntity {
  final String id;
  final String name;
  final String description;
  final String? image;
  final String? coverImage;
  final String category;
  final LocationEntity location;
  final String status;
  final String hostCompany;
  final String isRecurring;
  final DateTime date;
  final String time;
  final String price;
  final String type;
  final bool paid;
  final String host;
  final List<dynamic> attendees;
  final int v;

  EventEntity({
    required this.id,
    required this.name,
    required this.description,
    this.image,
    this.coverImage,  
    required this.category,
    required this.location,
    required this.status,
    required this.hostCompany,
    required this.isRecurring,
    required this.date,
    required this.time,
    required this.price,
    required this.type,
    required this.paid,
    required this.host,
    required this.attendees,
    required this.v,
  });

  static empty() {
    return EventEntity(
      id: 'unknown',
      name: 'unknown',
      description: 'unknown',
      image: 'unknown',
      coverImage: 'unknown',
      category: 'unknown',
      location: LocationEntity.empty(),
      status: 'unknown',
      hostCompany: 'unknown',
      isRecurring: 'unknown',
      date: DateTime.now(),
      time: 'unknown',
      price: 'unknown',
      type: 'unknown',
      paid: false,
      host: 'unknown',
      attendees: [],
      v: 0,
    );
  }
}

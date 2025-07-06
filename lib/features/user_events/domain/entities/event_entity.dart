import 'package:eventy/features/personalization/domain/entities/user_entity.dart';
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
  final String? price;
  final String type;
  final bool paid;
  final String host;
  final List<dynamic> attendees;
  final int v;

  final UserEntity user;

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
    required this.user,
  });

  // copyWith
  EventEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    String? coverImage,
    String? category,
    LocationEntity? location,
    String? status,
    String? hostCompany,
    String? isRecurring,
    DateTime? date,
    String? time,
    String? price,
    String? type,
    bool? paid,
    String? host,
    List<dynamic>? attendees,
    int? v,
    isJoined,
    UserEntity? user,
  }) {
    return EventEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      coverImage: coverImage ?? this.coverImage,
      category: category ?? this.category,
      location: location ?? this.location,
      status: status ?? this.status,
      hostCompany: hostCompany ?? this.hostCompany,
      isRecurring: isRecurring ?? this.isRecurring,
      date: date ?? this.date,
      time: time ?? this.time,
      price: price ?? this.price,
      type: type ?? this.type,
      paid: paid ?? this.paid,
      host: host ?? this.host,
      attendees: attendees ?? this.attendees,
      v: v ?? this.v,
      user: user ?? this.user,
    );
  }

  static empty() {
    return EventEntity(
      id: 'unknown',
      name: 'unknown',
      description: 'unknown',
      image:
          'https://static.vecteezy.com/system/resources/thumbnails/041/388/388/small/ai-generated-concert-crowd-enjoying-live-music-event-photo.jpg',
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
      user: UserEntity.empty(),
      v: 0,
    );
  }
}

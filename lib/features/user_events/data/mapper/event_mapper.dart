import 'package:eventy/features/user_events/data/mapper/location_mapper.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

extension EventMapper on EventModel {
  EventEntity toEntity() => EventEntity(
    id: id ?? 'unknown',
    name: name ?? 'unknown',
    description: description ?? 'unknown',
    image:
        image ??
        'https://media.istockphoto.com/id/499517325/photo/a-man-speaking-at-a-business-conference.jpg?s=612x612&w=0&k=20&c=gWTTDs_Hl6AEGOunoQ2LsjrcTJkknf9G8BGqsywyEtE=',
    coverImage:
        coverImage ??
        'https://media.istockphoto.com/id/499517325/photo/a-man-speaking-at-a-business-conference.jpg?s=612x612&w=0&k=20&c=gWTTDs_Hl6AEGOunoQ2LsjrcTJkknf9G8BGqsywyEtE=',
    category: category ?? 'unknown',
    location: location?.toEntity() ?? LocationEntity.empty(),
    status: status ?? 'unknown',
    hostCompany: hostCompany ?? 'unknown',
    isRecurring: isRecurring ?? 'unknown',
    date: _parseDate(date),
    time: time ?? 'unknown',
    price: price ?? 'unknown',
    type: type ?? 'unknown',
    paid: paid ?? false,
    host: host ?? 'unknown',
    attendees: attendees ?? [],
    v: v ?? 0,
  );

  DateTime _parseDate(String? value) {
    if (value == null) return DateTime.now();
    return DateTime.tryParse(value) ?? DateTime.now();
  }
}

extension EventEntityMapper on EventEntity {
  EventModel toModel() => EventModel(
    id: id,
    name: name,
    description: description,
    category: category,
    location: location.toModel(),
    status: status,
    hostCompany: hostCompany,
    isRecurring: isRecurring,
    date: date.toIso8601String(),
    time: time,
    price: price,
    type: type,
    paid: paid,
    host: host,
    attendees: attendees,
    v: v,
  );
}

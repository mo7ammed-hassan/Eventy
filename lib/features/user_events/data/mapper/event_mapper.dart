import 'package:eventy/features/user_events/data/mapper/location_mapper.dart';
import 'package:eventy/features/user_events/data/models/event_model.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

extension EventMapper on EventModel {
  EventEntity toEntity() => EventEntity(
    id: id ?? 'unknown',
    name: name ?? 'unknown',
    description: description ?? 'unknown',
    category: category ?? 'unknown',
    location: location?.toEntity() ?? LocationEntity.empty(),
    status: status ?? 'unknown',
    hostCompany: hostCompany ?? 'unknown',
    isRecurring: isRecurring ?? 'unknown',
    date: date ?? DateTime.now().toString(),
    time: time ?? 'unknown',
    price: price ?? 'unknown',
    type: type ?? 'unknown',
    paid: paid ?? false,
    host: host ?? 'unknown',
    attendees: attendees ?? [],
    v: v ?? 0,
  );
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
    date: date,
    time: time,
    price: price,
    type: type,
    paid: paid,
    host: host,
    attendees: attendees,
    v: v,
  );
}

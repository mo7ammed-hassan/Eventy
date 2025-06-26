import 'package:eventy/features/create_event/data/models/create_event_model.dart';
import 'package:eventy/features/create_event/domain/entities/create_event_entity.dart';
import 'package:eventy/features/user_events/data/mapper/location_mapper.dart';
import 'package:eventy/features/user_events/domain/entities/location_entity.dart';

extension CreateEventMapper on CreateEventModel {
  CreateEventEntity toEntity() {
    return CreateEventEntity(
      id: id,
      name: name ?? '',
      description: description ?? '',
      category: category ?? '',
      location: location?.toEntity() ?? LocationEntity.empty(),
      status: status ?? 'draft',
      image: image ?? '',
      coverImage: coverImage ?? '',
      isRecurring: isRecurring ?? 'Not Annual',
      date: _parseDate(date),
      time: time ?? '',
      price: price ?? '0',
      type: type ?? 'public',
      paid: paid ?? false,
      host: host ?? '',
      attendees: attendees ?? [],
      formatedDate: _parseDate(formatedDate),
      iV: iV,
    );
  }

  DateTime _parseDate(String? value) {
    if (value == null) return DateTime.now();
    return DateTime.tryParse(value) ?? DateTime.now();
  }
}

extension CreateEventEntityMapper on CreateEventEntity {
  CreateEventModel toModel() {
    return CreateEventModel(
      id: id,
      name: name,
      description: description,
      category: category,
      location: location?.toModel(),
      status: status,
      image: image,
      coverImage: coverImage,
      isRecurring: isRecurring,
      date: date?.toIso8601String(),
      time: time,
      price: price,
      type: type,
      paid: paid,
      host: host,
      attendees: attendees,
      formatedDate: formatedDate?.toIso8601String(),
      iV: iV,
    );
  }
}

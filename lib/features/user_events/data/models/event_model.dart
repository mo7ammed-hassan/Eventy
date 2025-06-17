import 'location_model.dart';

class EventModel {
  String? id;
  String? name;
  String? description;
  String? category;
  LocationModel? location;
  String? status;
  String? hostCompany;
  String? isRecurring;
  String? date;
  String? time;
  String? price;
  String? type;
  bool? paid;
  String? host;
  List<dynamic>? attendees;
  int? v;

  EventModel({
    this.id,
    this.name,
    this.description,
    this.category,
    this.location,
    this.status,
    this.hostCompany,
    this.isRecurring,
    this.date,
    this.time,
    this.price,
    this.type,
    this.paid,
    this.host,
    this.attendees,
    this.v,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json['_id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    category: json['category'] as String?,
    location: json['location'] == null
        ? null
        : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    status: json['status'] as String?,
    hostCompany: json['hostCompany'] as String?,
    isRecurring: json['isRecurring'] as String?,
    date: json['date'] as String?,
    time: json['time'] as String?,
    price: json['price'] as String?,
    type: json['type'] as String?,
    paid: json['paid'] as bool?,
    host: json['host'] as String?,
    attendees: json['attendees'] as List<dynamic>?,
    v: json['__v'] as int?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'category': category,
    'location': location?.toJson(),
    'status': status,
    'hostCompany': hostCompany,
    'isRecurring': isRecurring,
    'date': date,
    'time': time,
    'price': price,
    'type': type,
    'paid': paid,
    'host': host,
    'attendees': attendees,
    '__v': v,
  };

  static DateTime? parseDate(dynamic value) {
    if (value == null) {
      return null;
    } else if (value is DateTime) {
      return value.toUtc();
    } else if (value is String) {
      return DateTime.tryParse(value);
    } else {
      return null;
    }
  }
}

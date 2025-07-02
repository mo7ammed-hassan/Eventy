import '../../../location/data/location_model.dart';

class EventModel {
  String? id;
  String? name;
  String? image;
  String? coverImage;
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
    this.image,
    this.coverImage,
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
    image: json['image'] as String?,
    coverImage: json['coverImage'] as String?,
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
    price: json['price'].toString(),
    type: json['type'] as String?,
    paid: json['paid'] as bool?,
    host: json['host'] as String?,
    attendees: (json['attendees'] is List)
        ? List<dynamic>.from(json['attendees'])
        : [],
    v: json['__v'] as int?,
  );

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

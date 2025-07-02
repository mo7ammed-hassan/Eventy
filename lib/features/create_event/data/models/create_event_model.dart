import 'package:eventy/core/utils/helpers/extensions/json_extensions.dart';
import 'package:eventy/features/location/data/location_model.dart';

class CreateEventModel {
  final String? name;
  final String? description;
  final String? category;
  final LocationModel? location;
  final String? status;
  final String? image;
  final String? coverImage;
  final String? isRecurring;
  final String? date;
  final String? time;
  final String? price;
  final String? type;
  final bool? paid;
  final String? host;
  final List<dynamic>? attendees;
  final String? sId;
  final int? iV;
  final String? formatedDate;
  final String? id;

  const CreateEventModel({
    this.name,
    this.description,
    this.category,
    this.location,
    this.status,
    this.image,
    this.coverImage,
    this.isRecurring,
    this.date,
    this.time,
    this.price,
    this.type,
    this.paid,
    this.host,
    this.attendees,
    this.sId,
    this.iV,
    this.formatedDate,
    this.id,
  });

  factory CreateEventModel.fromJson(Map<String, dynamic> json) {
    return CreateEventModel(
      name: json.getValue<String>('name'),
      description: json.getValue<String>('description'),
      category: json.getValue<String>('category'),
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      status: json.getValue<String>('status'),
      image: json.getValue<String>('image'),
      coverImage: json.getValue<String>('coverImage'),
      isRecurring: json.getValue<String>('isRecurring'),
      date: json.getValue<String>('date'),
      time: json.getValue<String>('time'),
      price: json.getValue<String>('price'),
      type: json.getValue<String>('type'),
      paid: json.getValue<bool>('paid', defaultValue: false),
      host: json.getValue<String>('host'),
      attendees: json.getValue<List<dynamic>>('attendees', defaultValue: []),
      sId: json.getValue<String>('_id'),
      iV: json.getValue<int>('__v'),
      formatedDate: json.getValue<String>('formattedDate'),
      id: json.getValue<String>('id'),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'category': category,
    'location': location?.toJson(),
    'status': status,
    'image': image,
    'coverImage': coverImage,
    'isRecurring': isRecurring,
    'date': date,
    'time': time,
    'price': price,
    'type': type,
    'paid': paid,
    'host': host,
    'attendees': attendees,
    'formattedDate': formatedDate,
  };

  static empty() => const CreateEventModel();
}

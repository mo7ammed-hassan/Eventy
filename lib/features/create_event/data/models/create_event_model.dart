import 'package:eventy/core/utils/helpers/extensions/json_extensions.dart';
import 'package:eventy/features/location/data/location_model.dart';

class CreateEventModel {
  final String? name;
  final String? description;
  final String? category;
  final LocationModel? location;
  final String? image;
  final String? coverImage;
  final String? isRecurring;
  final String? date;
  final String? time;
  final String? price;
  final String? type;
  final String? host;
  final List<dynamic>? attendees;

  const CreateEventModel({
    this.name,
    this.description,
    this.category,
    this.location,
    this.image,
    this.coverImage,
    this.isRecurring,
    this.date,
    this.time,
    this.price,
    this.type,
    this.host,
    this.attendees,
  });

  factory CreateEventModel.fromJson(Map<String, dynamic> json) {
    return CreateEventModel(
      name: json.getValue<String>('name'),
      description: json.getValue<String>('description'),
      category: json.getValue<String>('category'),
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      image: json.getValue<String>('image'),
      coverImage: json.getValue<String>('coverImage'),
      isRecurring: json.getValue<String>('isRecurring'),
      date: json.getValue<String>('date'),
      time: json.getValue<String>('time'),
      price: json.getValue<String>('price'),
      type: json.getValue<String>('type'),
      host: json.getValue<String>('host'),
      attendees: json.getValue<List<dynamic>>('attendees', defaultValue: []),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'category': category,
    'location': location?.toMap(),
    'image': image,
    'coverImage': coverImage,
    'isRecurring': isRecurring,
    'date': date,
    'time': time,
    'price': price,
    'type': type,
    'host': host,
    'attendees': attendees,
  };

  static empty() => const CreateEventModel();
}

import 'package:eventy/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class FreeEvent extends StatefulWidget {
  const FreeEvent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FreeEventState createState() => _FreeEventState();
}

class _FreeEventState extends State<FreeEvent> {
  final Location _location = Location();
  Future<LocationData?>? _locationFuture;

  @override
  void initState() {
    super.initState();
    _locationFuture = _getLocation();
  }

  Future<LocationData?> _getLocation() async {
    if (!(await _location.serviceEnabled()) &&
        !(await _location.requestService())) {
      return null;
    }
    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return null;
      }
    }
    return _location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              // margin: const EdgeInsets.only(bottom: 20),
              child: _buildEventImage(),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 290),
              child: _buildCurvedContainer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventImage() {
    return Image.asset(
      'assets/images/eventyFree.jpg',
      width: double.infinity,
      fit: BoxFit.cover,
      height: 350,
    );
  }

  Widget _buildCurvedContainer() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(60),
        topRight: Radius.circular(60),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(25),
        color: Colors.white,
        child: _buildEventContent(),
      ),
    );
  }

  Widget _buildEventContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildEventTitle(),
        const SizedBox(height: 10),
        _buildHostName(),
        const SizedBox(height: 10),
        _buildDescription(),
        const Divider(color: Colors.grey, thickness: 1),
        _buildEventDetails(),
        const SizedBox(height: 30),
        _buildLocationSection(),
        const SizedBox(height: 20),
        _buildPreviousEvent(),
        const SizedBox(height: 20),
        _buildJoinButton(),
      ],
    );
  }

  Widget _buildEventTitle() {
    return Row(
      children: [
        const Text(
          'Event Name',
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 20),
        Text(
          'Free event',
          style: TextStyle(
            color: Colors.blue[900],
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const Spacer(),
        _buildEventDetailsRow(Icons.calendar_today_outlined, '25 NOV, 25'),
      ],
    );
  }

  Widget _buildHostName() {
    return const Row(
      children: [
        Icon(Icons.circle, size: 30, color: Color.fromARGB(255, 92, 92, 92)),
        SizedBox(width: 5),
        Text('Host Name', style: TextStyle(color: Colors.black, fontSize: 15)),
      ],
    );
  }

  Widget _buildDescription() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
          style: TextStyle(color: Colors.black, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildEventDetails() {
    return Column(
      children: [
        _buildEventDetailsRow(Icons.access_time, '9:00 PM'),
        const SizedBox(height: 20),
        _buildEventDetailsRow(Icons.computer_outlined, 'AI Event'),
        const SizedBox(height: 20),
        _buildEventDetailsRow(Icons.calendar_today_outlined, '25 NOV, 25'),
      ],
    );
  }

  Widget _buildEventDetailsRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.blue[900]),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          child: FutureBuilder<LocationData?>(
            future: _locationFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError || !snapshot.hasData) {
                return const Center(child: Text("Location not available"));
              }
              final data = snapshot.data!;
              return Center(
                child: Text(
                  "Lat: ${data.latitude?.toStringAsFixed(4)}\nLng: ${data.longitude?.toStringAsFixed(4)}",
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPreviousEvent() {
    return const Center(
      child: Image(
        image: AssetImage(AppImages.defaultImage),
        fit: BoxFit.cover,
        width: 50,
      ),
    );
  }

  Widget _buildJoinButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Color.fromARGB(255, 197, 38, 125),
              width: 1.5,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          'Join Event',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}

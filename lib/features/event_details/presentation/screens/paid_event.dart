import 'package:eventy/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:location/location.dart';
import 'package:eventy/features/payment/screens/payment_options_screen.dart';

class PaidEvent extends StatefulWidget {
  const PaidEvent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaidEventState createState() => _PaidEventState();
}

class _PaidEventState extends State<PaidEvent> {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: isDark ? Colors.black : Colors.white,
        title: const Text('Event Name'),
        actions: [
          IconButton(icon: const Icon(Iconsax.star), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(child: _buildEventImage()),
            Padding(
              padding: const EdgeInsets.only(top: 290),
              child: _buildCurvedContainer(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 10,
          left: 10,
          right: 10,
        ),
        child: _buildJoinButton(),
      ),
    );
  }

  Widget _buildEventImage() {
    return Image.asset(
      'assets/images/payedImg.jpg',
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
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black
            : Colors.white,
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
      ],
    );
  }

  Widget _buildEventTitle() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          iconSize: 24,
        ),
        const SizedBox(width: 8),
        Text(
          'Event Name',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 22),
          maxLines: 1,
        ),
        const SizedBox(width: 50),
        const Flexible(
          child: Text(
            '100.00 EGP',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildHostName() {
    return Row(
      children: [
        const Icon(
          Icons.circle,
          size: 30,
          color: Color.fromARGB(255, 92, 92, 92),
        ),
        const SizedBox(width: 5),
        Text(
          'Host Name',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 5),
        Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
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
        Icon(icon, size: 24, color: Colors.red[900]),
        const SizedBox(width: 10),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Container(
          height: MediaQuery.sizeOf(context).height * 0.2,
          width: double.infinity,
          padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[200],
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
              //final data = snapshot.data!;
              // return Center(
              //   child: Text(
              //     "Lat: ${data.latitude?.toStringAsFixed(4)}\nLng: ${data.longitude?.toStringAsFixed(4)}",
              //     textAlign: TextAlign.center,
              //   ),
              // );

              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/test_map.png',
                  fit: BoxFit.cover,
                ),
              );

              // return GoogleMap(
              //   initialCameraPosition: CameraPosition(
              //     target: LatLng(data.latitude!, data.longitude!),
              //     zoom: 15,
              //   ),
              //   markers: {
              //     Marker(
              //       markerId: const MarkerId('1'),
              //       position: LatLng(data.latitude!, data.longitude!),
              //     ),
              //   },
              //   mapType: MapType.normal,
              // );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPreviousEvent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          'Previous Event',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.2,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Image.asset(
              AppImages.defaultImage,
              fit: BoxFit.cover,
              width: 50,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJoinButton() {
    return SizedBox(
      height: 50,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaymentOptionsScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            elevation: 5,
            padding: const EdgeInsets.symmetric(
              horizontal: 120,
              vertical: 16.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                color: Color.fromARGB(255, 197, 38, 125),
                width: 1.5,
              ),
            ),
            // backgroundColor: Colors.white,
          ),
          child: const FittedBox(child: Text('Continue to Payment')),
        ),
      ),
    );
  }
}

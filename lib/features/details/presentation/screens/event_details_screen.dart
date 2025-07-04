import 'package:eventy/core/constants/app_images.dart';
import 'package:eventy/features/user_events/domain/entities/event_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final event = ModalRoute.of(context)!.settings.arguments as EventEntity;
    
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final eventDate = DateFormat('EEEE, MMMM d, y').format(event.date);
    final formattedTime = event.time;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  event.coverImage != null
                      ? Image.network(
                          event.coverImage ?? AppImages.defaultEventImageUrl,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple.shade800,
                                Colors.deepPurple.shade400,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.event,
                              size: 100,
                              color: Colors.white54,
                            ),
                          ),
                        ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.5),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pinned: true,
            backgroundColor: Colors.deepPurple,
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _shareEvent(context),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (event.status == 'pending')
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Text(
                        'Pending Approval',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.orange.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    event.name,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    icon: Icons.calendar_month,
                    text: '$eventDate • $formattedTime',
                    theme: theme,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    icon: Icons.location_pin,
                    text: event.location.address ?? 'Unknown',
                    theme: theme,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    icon: Icons.money,
                    text: event.price == '0' ? 'Free' : '${event.price} EGP',
                    theme: theme,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    icon: Icons.group,
                    text: '${event.type} Event',
                    theme: theme,
                  ),
                  const SizedBox(height: 12),
                  Chip(
                    label: Text(event.category),
                    backgroundColor: isDarkMode
                        ? Colors.purple.shade900
                        : Colors.purple.shade100,
                    labelStyle: TextStyle(
                      color: isDarkMode
                          ? Colors.purple.shade200
                          : Colors.purple.shade800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'About this event',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    event.description,
                    style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Location',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton.icon(
                    icon: const Icon(Icons.map),
                    label: const Text('Get Directions'),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hosted by',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade100,
                      child: const Icon(
                        Icons.business,
                        color: Colors.deepPurple,
                      ),
                    ),
                    title: const Text('Organizer'),
                    subtitle: const Text('Finance & Business Network'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildActionButtons(context, event),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String text,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: theme.textTheme.bodyLarge)),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, EventEntity event) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.bookmark_border),
                label: const Text('Save'),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                icon: const Icon(Icons.event_available),
                label: Text(event.price == '0' ? 'Register' : 'Get Tickets'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareEvent(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality would be implemented here'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class ManageAppointmentsScreen extends StatefulWidget {
  const ManageAppointmentsScreen({super.key});

  @override
  State<ManageAppointmentsScreen> createState() =>
      _ManageAppointmentsScreenState();
}

class _ManageAppointmentsScreenState extends State<ManageAppointmentsScreen> {
  String _selectedFilter = 'All';

  // Mock data - replace with Firebase query
  // TODO: Fetch from Firestore: collection('appointments').orderBy('date')
  final List<Map<String, dynamic>> _appointments = [
    {
      'id': '1',
      'title': 'Initial Consultation',
      'therapist': 'Dr. Sarah Johnson',
      'parent': 'John Doe',
      'child': 'Emma',
      'date': '2024-01-15',
      'time': '10:00 AM',
      'status': 'CONFIRMED',
    },
    {
      'id': '2',
      'title': 'Follow-up Session',
      'therapist': 'Dr. Michael Chen',
      'parent': 'Sarah Smith',
      'child': 'Michael',
      'date': '2024-01-16',
      'time': '02:00 PM',
      'status': 'PENDING',
    },
    {
      'id': '3',
      'title': 'Assessment',
      'therapist': 'Dr. Emily Rodriguez',
      'parent': 'Robert Johnson',
      'child': 'Sophia',
      'date': '2024-01-12',
      'time': '11:00 AM',
      'status': 'COMPLETED',
    },
    {
      'id': '4',
      'title': 'Therapy Session',
      'therapist': 'Dr. James Wilson',
      'parent': 'Lisa Brown',
      'child': 'Oliver',
      'date': '2024-01-10',
      'time': '03:00 PM',
      'status': 'CANCELLED',
    },
  ];

  List<Map<String, dynamic>> get _filteredAppointments {
    if (_selectedFilter == 'All') {
      return _appointments;
    }
    return _appointments
        .where((apt) => apt['status'] == _selectedFilter.toUpperCase())
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Manage Appointments',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter Chips
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Pending'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Confirmed'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Completed'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Cancelled'),
                ],
              ),
            ),
          ),

          // Appointments List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredAppointments.length,
              itemBuilder: (context, index) {
                final appointment = _filteredAppointments[index];
                return _buildAppointmentCard(appointment);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = label;
        });
      },
      selectedColor: AppColors.primaryBlue,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.textDark,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    final status = appointment['status'];
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 'CONFIRMED':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'PENDING':
        statusColor = Colors.orange;
        statusIcon = Icons.access_time;
        break;
      case 'COMPLETED':
        statusColor = Colors.blue;
        statusIcon = Icons.check_circle_outline;
        break;
      case 'CANCELLED':
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with status and menu
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert, color: AppColors.textLight),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditDialog(appointment);
                  } else if (value == 'delete') {
                    _showDeleteDialog(appointment);
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Title
          Text(
            appointment['title'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 12),

          // Details
          _buildDetailRow(
            Icons.psychology,
            'Therapist: ${appointment['therapist']}',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            Icons.person_outline,
            'Parent: ${appointment['parent']}',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            Icons.child_care_outlined,
            'Child: ${appointment['child']}',
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            Icons.calendar_today_outlined,
            appointment['date'],
          ),
          const SizedBox(height: 8),
          _buildDetailRow(
            Icons.access_time_outlined,
            appointment['time'],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textLight),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: AppColors.textDark),
        ),
      ],
    );
  }

  void _showEditDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit Appointment'),
        content: Text(
          'Edit appointment: ${appointment['title']}\n\nThis feature will be fully implemented with Firebase.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement edit functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit feature coming soon')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete Appointment'),
          ],
        ),
        content:
            Text('Are you sure you want to delete "${appointment['title']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _appointments.removeWhere((a) => a['id'] == appointment['id']);
              });
              // TODO: Delete from Firebase
              /*
              await FirebaseFirestore.instance
                  .collection('appointments')
                  .doc(appointment['id'])
                  .delete();
              */
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Appointment deleted'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

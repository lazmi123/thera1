import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class ViewAppointmentsScreen extends StatefulWidget {
  const ViewAppointmentsScreen({super.key});

  @override
  State<ViewAppointmentsScreen> createState() =>
      _ViewAppointmentsScreenState();
}

class _ViewAppointmentsScreenState extends State<ViewAppointmentsScreen> {
  // Mock data - replace with Firebase query
  // TODO: Fetch from Firestore:
  // collection('appointments').where('therapistId', isEqualTo: currentUserId).orderBy('date')
  final List<Map<String, dynamic>> _appointments = [
    {
      'id': '1',
      'title': 'Initial Consultation',
      'parentName': 'John Doe',
      'childName': 'Emma',
      'date': '2024-01-15',
      'time': '10:00 AM',
      'status': 'CONFIRMED',
    },
    {
      'id': '2',
      'title': 'Follow-up Session',
      'parentName': 'Sarah Smith',
      'childName': 'Michael',
      'date': '2024-01-16',
      'time': '02:00 PM',
      'status': 'PENDING',
    },
    {
      'id': '3',
      'title': 'Assessment',
      'parentName': 'Robert Johnson',
      'childName': 'Sophia',
      'date': '2024-01-12',
      'time': '11:00 AM',
      'status': 'COMPLETED',
    },
  ];

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
          'My Appointments',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _appointments.length,
        itemBuilder: (context, index) {
          final appointment = _appointments[index];
          return _buildAppointmentCard(appointment);
        },
      ),
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
          // Status Badge
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
              if (status == 'PENDING')
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () => _confirmAppointment(appointment),
                      tooltip: 'Confirm',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () => _cancelAppointment(appointment),
                      tooltip: 'Decline',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
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

          // Parent Info
          Row(
            children: [
              Icon(Icons.person_outline, size: 18, color: AppColors.textLight),
              const SizedBox(width: 8),
              Text(
                'Parent: ${appointment['parentName']}',
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Child Info
          Row(
            children: [
              Icon(Icons.child_care_outlined,
                  size: 18, color: AppColors.textLight),
              const SizedBox(width: 8),
              Text(
                'Child: ${appointment['childName']}',
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Date
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 8),
              Text(
                appointment['date'],
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Time
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                size: 18,
                color: AppColors.textLight,
              ),
              const SizedBox(width: 8),
              Text(
                appointment['time'],
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmAppointment(Map<String, dynamic> appointment) {
    setState(() {
      _appointments.firstWhere(
        (a) => a['id'] == appointment['id'],
      )['status'] = 'CONFIRMED';
    });
    // TODO: Update in Firebase
    /*
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointment['id'])
        .update({'status': 'CONFIRMED'});
    */
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment confirmed'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _cancelAppointment(Map<String, dynamic> appointment) {
    setState(() {
      _appointments.firstWhere(
        (a) => a['id'] == appointment['id'],
      )['status'] = 'CANCELLED';
    });
    // TODO: Update in Firebase
    /*
    await FirebaseFirestore.instance
        .collection('appointments')
        .doc(appointment['id'])
        .update({'status': 'CANCELLED'});
    */
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Appointment cancelled'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

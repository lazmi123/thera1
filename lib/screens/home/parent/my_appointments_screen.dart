import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class MyAppointmentsScreen extends StatefulWidget {
  const MyAppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<MyAppointmentsScreen> createState() => _MyAppointmentsScreenState();
}

class _MyAppointmentsScreenState extends State<MyAppointmentsScreen> {
  // Mock data - replace with Firebase query
  // TODO: Fetch from Firestore:
  // collection('appointments').where('parentId', isEqualTo: currentUserId).orderBy('date')
  final List<Map<String, dynamic>> _appointments = [
    {
      'id': '1',
      'title': 'Initial Consultation',
      'therapist': 'Dr. Sarah Johnson',
      'date': '2024-01-15',
      'time': '10:00 AM',
      'status': 'CONFIRMED',
    },
    {
      'id': '2',
      'title': 'Follow-up Session',
      'therapist': 'Dr. Michael Chen',
      'date': '2024-01-18',
      'time': '02:00 PM',
      'status': 'PENDING',
    },
    {
      'id': '3',
      'title': 'Family Counseling',
      'therapist': 'Dr. Emily Rodriguez',
      'date': '2024-01-12',
      'time': '11:00 AM',
      'status': 'COMPLETED',
    },
    {
      'id': '4',
      'title': 'Assessment',
      'therapist': 'Dr. James Wilson',
      'date': '2024-01-10',
      'time': '03:00 PM',
      'status': 'CANCELLED',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('My Appointments', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
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
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Badge
          Row(
            children: [
              Icon(statusIcon, color: statusColor, size: 20),
              SizedBox(width: 8),
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

          SizedBox(height: 12),

          // Title
          Text(
            appointment['title'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),

          SizedBox(height: 12),

          // Therapist
          Row(
            children: [
              Icon(Icons.person_outline, size: 18, color: AppColors.textLight),
              SizedBox(width: 8),
              Text(
                appointment['therapist'],
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Date
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: AppColors.textLight,
              ),
              SizedBox(width: 8),
              Text(
                appointment['date'],
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Time
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                size: 18,
                color: AppColors.textLight,
              ),
              SizedBox(width: 8),
              Text(
                appointment['time'],
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),

          // Action Buttons (only for CONFIRMED status)
          if (status == 'CONFIRMED') ...[
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showRescheduleDialog(appointment);
                    },
                    icon: Icon(Icons.sync, size: 18),
                    label: Text('Reschedule'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryBlue,
                      side: BorderSide(
                        color: AppColors.primaryBlue,
                        width: 1.5,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showCancelDialog(appointment);
                    },
                    icon: Icon(Icons.close, size: 18),
                    label: Text('Cancel'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: BorderSide(color: Colors.red, width: 1.5),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  void _showRescheduleDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.sync, color: AppColors.primaryBlue, size: 28),
            SizedBox(width: 8),
            Text('Reschedule'),
          ],
        ),
        content: Text(
          'Reschedule "${appointment['title']}" appointment?\n\nThis feature will be available soon.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement reschedule functionality
              /*
              await FirebaseFirestore.instance
                  .collection('appointments')
                  .doc(appointment['id'])
                  .update({'status': 'rescheduling'});
              */
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Reschedule feature coming soon')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
            ),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.cancel, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text('Cancel Appointment'),
          ],
        ),
        content: Text(
          'Are you sure you want to cancel "${appointment['title']}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
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
                SnackBar(
                  content: Text('Appointment cancelled'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }
}

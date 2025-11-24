import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class ViewTherapistsScreen extends StatefulWidget {
  const ViewTherapistsScreen({Key? key}) : super(key: key);

  @override
  State<ViewTherapistsScreen> createState() => _ViewTherapistsScreenState();
}

class _ViewTherapistsScreenState extends State<ViewTherapistsScreen> {
  // Mock data - replace with Firebase query
  // TODO: Fetch from Firestore: collection('therapists').where('isActive', isEqualTo: true)
  final List<Map<String, dynamic>> _therapists = [
    {
      'id': '1',
      'name': 'Dr. Sarah Johnson',
      'specialization': 'Child Psychology',
      'rating': 4.8,
      'experience': 12,
      'availability': 'Mon, Wed, Fri',
      'location': 'New York, NY',
      'initial': 'D',
    },
    {
      'id': '2',
      'name': 'Dr. Michael Chen',
      'specialization': 'Behavioral Therapy',
      'rating': 4.9,
      'experience': 15,
      'availability': 'Tue, Thu, Sat',
      'location': 'Los Angeles, CA',
      'initial': 'D',
    },
    {
      'id': '3',
      'name': 'Dr. Emily Rodriguez',
      'specialization': 'Family Counseling',
      'rating': 4.7,
      'experience': 10,
      'availability': 'Mon, Tue, Thu',
      'location': 'Chicago, IL',
      'initial': 'D',
    },
    {
      'id': '4',
      'name': 'Dr. James Wilson',
      'specialization': 'Autism Spectrum',
      'rating': 4.9,
      'experience': 18,
      'availability': 'Wed, Fri, Sat',
      'location': 'Houston, TX',
      'initial': 'D',
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
        title: Text(
          'Available Therapists',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: _therapists.length,
        itemBuilder: (context, index) {
          final therapist = _therapists[index];
          return _buildTherapistCard(therapist);
        },
      ),
    );
  }

  Widget _buildTherapistCard(Map<String, dynamic> therapist) {
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
          Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.primaryBlue,
                child: Text(
                  therapist['initial'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 16),

              // Therapist Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      therapist['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      therapist['specialization'],
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textLight,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        SizedBox(width: 4),
                        Text(
                          '${therapist['rating']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '• ${therapist['experience']} years',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Availability
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: AppColors.textLight,
              ),
              SizedBox(width: 8),
              Text(
                therapist['availability'],
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Location
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18,
                color: AppColors.textLight,
              ),
              SizedBox(width: 8),
              Text(
                therapist['location'],
                style: TextStyle(fontSize: 14, color: AppColors.textDark),
              ),
            ],
          ),

          SizedBox(height: 16),

          // Book Appointment Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showBookingDialog(therapist);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: Text(
                'Book Appointment',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingDialog(Map<String, dynamic> therapist) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Book Appointment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Book appointment with ${therapist['name']}?'),
            SizedBox(height: 16),
            Text(
              'Specialization: ${therapist['specialization']}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'This will send a booking request.',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Save appointment to Firebase
              /*
              await FirebaseFirestore.instance.collection('appointments').add({
                'parentId': FirebaseAuth.instance.currentUser?.uid,
                'therapistId': therapist['id'],
                'therapistName': therapist['name'],
                'specialization': therapist['specialization'],
                'status': 'pending',
                'timestamp': FieldValue.serverTimestamp(),
              });
              */
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Booking request sent to ${therapist['name']}!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
            ),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

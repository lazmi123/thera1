import 'package:flutter/material.dart';
import '../../../utils/colors.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock data - replace with Firebase queries
  // TODO: Fetch from Firestore: collection('users')
  final List<Map<String, dynamic>> _therapists = [
    {
      'id': '1',
      'name': 'Dr. Sarah Johnson',
      'email': 'sarah.j@example.com',
      'specialization': 'Child Psychology',
      'status': 'Active',
    },
    {
      'id': '2',
      'name': 'Dr. Michael Chen',
      'email': 'michael.c@example.com',
      'specialization': 'Behavioral Therapy',
      'status': 'Active',
    },
  ];

  final List<Map<String, dynamic>> _parents = [
    {
      'id': '3',
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'children': 2,
      'status': 'Active',
    },
    {
      'id': '4',
      'name': 'Sarah Smith',
      'email': 'sarah.s@example.com',
      'children': 1,
      'status': 'Active',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Manage Users',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Therapists'),
            Tab(text: 'Parents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTherapistsList(),
          _buildParentsList(),
        ],
      ),
    );
  }

  Widget _buildTherapistsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _therapists.length,
      itemBuilder: (context, index) {
        final therapist = _therapists[index];
        return _buildUserCard(
          name: therapist['name'],
          email: therapist['email'],
          subtitle: therapist['specialization'],
          status: therapist['status'],
          icon: Icons.psychology,
          onEdit: () => _showEditDialog(therapist),
          onDelete: () => _showDeleteDialog(therapist),
        );
      },
    );
  }

  Widget _buildParentsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _parents.length,
      itemBuilder: (context, index) {
        final parent = _parents[index];
        return _buildUserCard(
          name: parent['name'],
          email: parent['email'],
          subtitle: '${parent['children']} children',
          status: parent['status'],
          icon: Icons.family_restroom,
          onEdit: () => _showEditDialog(parent),
          onDelete: () => _showDeleteDialog(parent),
        );
      },
    );
  }

  Widget _buildUserCard({
    required String name,
    required String email,
    required String subtitle,
    required String status,
    required IconData icon,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
            child: Icon(icon, color: AppColors.primaryBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textLight,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: AppColors.textLight),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.edit, size: 20),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
                onTap: onEdit,
              ),
              PopupMenuItem(
                child: Row(
                  children: const [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(color: Colors.red)),
                  ],
                ),
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Edit User'),
        content: Text(
          'Edit user: ${user['name']}\n\nThis feature will be fully implemented with Firebase.',
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
              /*
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user['id'])
                  .update({...});
              */
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

  void _showDeleteDialog(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('Delete User'),
          ],
        ),
        content: Text('Are you sure you want to delete ${user['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Delete from Firebase
              /*
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(user['id'])
                  .delete();
              */
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${user['name']} deleted'),
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

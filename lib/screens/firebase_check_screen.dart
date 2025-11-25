import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';

class FirebaseCheckScreen extends StatefulWidget {
  const FirebaseCheckScreen({super.key});

  @override
  State<FirebaseCheckScreen> createState() => _FirebaseCheckScreenState();
}

class _FirebaseCheckScreenState extends State<FirebaseCheckScreen> {
  bool isChecking = true;
  String statusMessage = 'Checking Firebase connection...';
  bool authOk = false;
  bool firestoreOk = false;
  String? errorDetails;

  @override
  void initState() {
    super.initState();
    _checkFirebaseServices();
  }

  Future<void> _checkFirebaseServices() async {
    setState(() {
      isChecking = true;
      statusMessage = 'Checking Firebase initialization...';
    });

    await Future.delayed(const Duration(seconds: 1));

    // Check if Firebase is initialized
    if (!firebaseInitialized) {
      setState(() {
        isChecking = false;
        statusMessage = 'Firebase not initialized';
        errorDetails = firebaseError ?? 'Unknown error';
      });
      return;
    }

    // Check Authentication
    setState(() {
      statusMessage = 'Checking Authentication...';
    });
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      // Try to access Firebase Auth
      FirebaseAuth.instance.authStateChanges();
      setState(() {
        authOk = true;
      });
    } catch (e) {
      setState(() {
        errorDetails = 'Authentication error: $e';
      });
    }

    // Check Firestore
    setState(() {
      statusMessage = 'Checking Firestore Database...';
    });
    
    await Future.delayed(const Duration(milliseconds: 500));
    
    try {
      // Try to access Firestore (this will fail if not configured)
      await FirebaseFirestore.instance
          .collection('_connection_test')
          .limit(1)
          .get()
          .timeout(const Duration(seconds: 5));
      setState(() {
        firestoreOk = true;
      });
    } catch (e) {
      setState(() {
        errorDetails = 'Firestore error: $e';
      });
    }

    setState(() {
      isChecking = false;
      if (authOk && firestoreOk) {
        statusMessage = 'All services connected!';
      } else {
        statusMessage = 'Some services are not available';
      }
    });

    // If everything is OK, proceed to login
    if (authOk && firestoreOk) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A90E2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                firebaseInitialized && authOk && firestoreOk
                    ? Icons.check_circle
                    : isChecking
                        ? Icons.cloud_sync
                        : Icons.error_outline,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 32),
              Text(
                statusMessage,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              if (isChecking)
                const CircularProgressIndicator(
                  color: Colors.white,
                )
              else if (!firebaseInitialized || !authOk || !firestoreOk) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildStatusRow(
                        'Firebase Initialized',
                        firebaseInitialized,
                      ),
                      const SizedBox(height: 8),
                      _buildStatusRow('Authentication', authOk),
                      const SizedBox(height: 8),
                      _buildStatusRow('Firestore Database', firestoreOk),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'To fix this:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '1. Go to Firebase Console:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('   console.firebase.google.com'),
                      SizedBox(height: 8),
                      Text(
                        '2. Select project: thera1-app',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '3. Enable these services:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('   • Authentication (Email/Password)'),
                      Text('   • Firestore Database'),
                      SizedBox(height: 8),
                      Text(
                        '4. Wait 2-3 minutes',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '5. Restart this app',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _checkFirebaseServices();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF4A90E2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Retry Connection'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Continue Anyway'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool status) {
    return Row(
      children: [
        Icon(
          status ? Icons.check_circle : Icons.cancel,
          color: status ? Colors.greenAccent : Colors.redAccent,
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

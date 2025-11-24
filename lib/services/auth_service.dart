import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Static variable to hold current user (for backward compatibility with existing code)
  static UserModel? currentUser;

  // Get current Firebase user
  User? get currentFirebaseUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign up with email and password
  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String name,
    required UserRole role,
    String? phoneNumber,
    // Therapist-specific fields
    String? specialization,
    int? yearsOfExperience,
    String? location,
    List<String>? availability,
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = result.user;
      if (firebaseUser == null) return null;

      // Create user model
      UserModel newUser = UserModel(
        uid: firebaseUser.uid,
        email: email,
        name: name,
        role: role,
        phoneNumber: phoneNumber,
        createdAt: DateTime.now(),
        specialization: specialization,
        yearsOfExperience: yearsOfExperience,
        location: location,
        availability: availability,
        isActive: role == UserRole.therapist ? true : null,
        rating: role == UserRole.therapist ? 0.0 : null,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(firebaseUser.uid).set(
            newUser.toMap(),
          );

      // Update display name
      await firebaseUser.updateDisplayName(name);

      // Set current user
      currentUser = newUser;

      return newUser;
    } on FirebaseAuthException catch (e) {
      print('Sign up error: ${e.message}');
      throw e;
    } catch (e) {
      print('Error during sign up: $e');
      rethrow;
    }
  }

  // Sign in with email and password
  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with Firebase Auth
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? firebaseUser = result.user;
      if (firebaseUser == null) return null;

      // Get user data from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      if (!userDoc.exists) {
        throw Exception('User data not found');
      }

      // Create user model
      UserModel user = UserModel.fromFirestore(userDoc);
      currentUser = user;

      return user;
    } on FirebaseAuthException catch (e) {
      print('Sign in error: ${e.message}');
      throw e;
    } catch (e) {
      print('Error during sign in: $e');
      rethrow;
    }
  }

  // Sign out
  Future<void> logout() async {
    try {
      await _auth.signOut();
      currentUser = null;
    } catch (e) {
      print('Error during logout: $e');
      rethrow;
    }
  }

  // Get user data by UID
  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) return null;

      return UserModel.fromFirestore(userDoc);
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  // Update user data
  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = Timestamp.now();
      await _firestore.collection('users').doc(uid).update(data);

      // Update current user if it's the same user
      if (currentUser?.uid == uid) {
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(uid).get();
        currentUser = UserModel.fromFirestore(userDoc);
      }
    } catch (e) {
      print('Error updating user data: $e');
      rethrow;
    }
  }

  // Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('Password reset error: ${e.message}');
      throw e;
    }
  }

  // Check if user is logged in and load their data
  Future<UserModel?> checkCurrentUser() async {
    try {
      User? firebaseUser = _auth.currentUser;
      if (firebaseUser == null) return null;

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      if (!userDoc.exists) return null;

      UserModel user = UserModel.fromFirestore(userDoc);
      currentUser = user;
      return user;
    } catch (e) {
      print('Error checking current user: $e');
      return null;
    }
  }
}

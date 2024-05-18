import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:discover_training_location/constants/named_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxController{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Rx<User?> user = Rx<User?>(null);
  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }
  Future<bool> isEmailRegistered(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking email registration: $e');
      return false;
    }
  }

  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return e.code;
      } else if (e.code == 'email-already-in-use') {
        return e.code;
      } else if (e.code == 'operation-not-allowed') {
        return e.code;
      } else {
        return e.code;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // اll
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print("Firebase Auth Error Code: ${e.code}");
      return mapFirebaseAuthErrorToMessage(
          e.code); // في مشكلة بتسجيل الدخول وانزل تحت شوف شو رح يرجع مسج
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return e.code;
      } else if (e.code == 'user-not-found') {
        return e.code;
      } else if (e.code == 'wrong-password') {
        return e.code;
      } else {
        return e.toString();
      }
    }
  }

  Future<void> resetPassword({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential;
  }

  //Future<UserCredential> signInWithFacebook() async {
  // Start the sign in flow
  //inal LoginResult loginResult = await FacebookAuth.instance.login();

  // Create credentials
  // final OAuthCredential facebookAuthCredential =
  //     FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // return the credential
  // return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
//  }

  //  OTP
  Future<void> registerUserWithPhone(
    String mobile,
    BuildContext context,
  ) async {
    final auth = FirebaseAuth.instance;
    // print(mobile);
    await auth.verifyPhoneNumber(
      phoneNumber: '+91$mobile',
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        Navigator.pushNamed(
          context,
          NamedRoutes.verifyCode,
          arguments: verificationId,
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(
        seconds: 120,
      ),
    );
  }

  String mapFirebaseAuthErrorToMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'This email address is not registered. Please sign up.';
      case 'wrong-password':
        return 'Wrong password. Please try again.';
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password.';
      default:
        return 'An error occurred. Please try again later.';
    }
  }
}

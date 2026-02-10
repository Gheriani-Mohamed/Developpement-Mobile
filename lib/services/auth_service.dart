// import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<User?> register(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return result.user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // A dummy register function
  Future<bool> register(String email, String password) async {
    // Simulate a successful registration
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  // Future<User?> login(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     return result.user;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // A dummy login function
  Future<bool> login(String email, String password) async {
    // Simulate a successful login
    await Future.delayed(const Duration(seconds: 1));
    if (email == "test@gmail.com" && password == "123456") {
      return true;
    }
    return false;
  }

  // Future<void> logout() async {
  //   await _auth.signOut();
  // }

  // A dummy logout function
  Future<bool> logout() async {
    // Simulate a successful logout
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}

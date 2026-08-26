import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {

    try {

      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser =
      await googleSignIn.authenticate();


      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;


      final credential =
      GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );


      final userCredential =
      await _auth.signInWithCredential(credential);


      return userCredential.user;


    } catch (e) {

      throw Exception(
        "Google Login Failed: $e",
      );

    }
  }


  Future<void> logout() async {

    await _auth.signOut();

    await GoogleSignIn.instance.signOut();

  }

}
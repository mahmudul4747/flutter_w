import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;

  var user = Rxn<User>();

  @override
  void onInit() {
    user.bindStream(auth.authStateChanges());
    super.onInit();
  }

  void login(String email, String pass) async {
    await auth.signInWithEmailAndPassword(
        email: email, password: pass);
  }

  void logout() {
    auth.signOut();
  }
}

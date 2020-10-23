class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signIn(UserApp user, Function onFail, Function onSuccess) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
    } on PlatformException catch (e) {
      print(getErrorString(e.code));
    }
  }
}
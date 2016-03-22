import 'google_signin_js/gapi/auth2.dart';

class GoogleSignInSuccess {
  GoogleUser googleUser;
  GoogleSignInSuccess(this.googleUser);
}

class GoogleSignInFailure {}

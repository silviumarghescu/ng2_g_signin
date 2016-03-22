@JS('gapi.auth2')
library gapi.auth2;

import 'package:js/js.dart';

@JS()
external GoogleAuth init(Params params);

@JS()
@anonymous
class Params {
  external String get client_id;

  external String get cookie_policy;

  external String get scope;

  external bool get fetch_basic_profile;

  external String get hosted_domain;

  external String get openid_realm;

  external factory Params(
      {String client_id,
      String cookie_policy,
      String scope,
      bool fetch_basic_profile,
      String hosted_domain,
      String openid_realm});
}

@JS()
external GoogleAuth getAuthInstance();

@JS()
class GoogleAuth {
  external CurrentUser get currentUser;

  external signOut();

  // How to express the return type is Promise?
  external disconnect();
}

@JS()
class CurrentUser {
  external GoogleUser get();
}

@JS()
class GoogleUser {
  external String getId();

  external bool isSignedIn();

  external BasicProfile getBasicProfile();

  external AuthResponse getAuthResponse();
}

@JS()
class BasicProfile {
  external String getId();

  external String getName();

  external String getImageUrl();

  external String getEmail();
}

@JS()
class AuthResponse {
  external String get access_token;

  // Nullable. Type `Null` may returns.
  external String get id_token;

  external String get login_hint;

  external String get scope;

  // Nullable. Type `Null` may returns.
  // Although the document says that following 3 properties' type are all `String`, they all actually return type `int`.
  // https://developers.google.com/identity/sign-in/web/reference#googleusergetauthresponse
  external int get expires_in;

  external int get first_issued_at;

  external int get expires_at;
}

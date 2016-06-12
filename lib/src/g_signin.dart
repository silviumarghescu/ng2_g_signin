import 'package:angular2/angular2.dart';
import 'package:js/js.dart';

import 'events.dart';
import 'google_signin_js/gapi.dart';
import 'google_signin_js/gapi/auth2.dart';
import 'google_signin_js/gapi/signin2.dart';

class ClientIdNotFoundError extends StateError {
  ClientIdNotFoundError(String message) : super(message);
}

@Component(
    selector: 'g-signin',
    template: '<div [id]="id"></div>',
    changeDetection: ChangeDetectionStrategy.OnPush)
class GSignin implements AfterViewInit {
  final String id = 'google-signin2';

  // Render options
  @Input()
  String scope;
  @Input()
  String width;
  @Input()
  String height;
  @Input()
  String longTitle;
  @Input()
  String theme;

  // Init params
  @Input()
  String clientId;
  @Input()
  String cookiePolicy;
  @Input()
  String fetchBasicProfile;
  @Input()
  String hostedDomain;
  @Input()
  String openidRealm;

  @Output()
  EventEmitter<GoogleSignInSuccess> googleSigninSuccess =
      new EventEmitter<GoogleSignInSuccess>();

  @Output()
  EventEmitter<GoogleSignInFailure> googleSignInFailure =
      new EventEmitter<GoogleSignInFailure>();

  ngAfterViewInit() {
    _auth2Init();
    _renderButton();
  }

  _auth2Init() {
    if (clientId == null)
      throw new ClientIdNotFoundError(
          'clientId property is necessary. (<google-signin clientId="..."></google-signin>)');

    load('auth2', allowInterop(() {
      init(new Params(
          client_id: clientId,
          cookie_policy: cookiePolicy,
          fetch_basic_profile: _nullableParseBool(fetchBasicProfile),
          hosted_domain: hostedDomain,
          openid_realm: openidRealm));
    }));
  }

  void _handleFailure() {
    googleSignInFailure.add(new GoogleSignInFailure());
  }

  void _handleSuccess(GoogleUser googleUser) {
    googleSigninSuccess.add(new GoogleSignInSuccess(googleUser));
  }

  bool _nullableParseBool(String boolString) {
    if (boolString == 'true') return true;
    if (boolString == 'false') return false;
    if (boolString == null) return null;
    throw ('true, false, or null are expected.');
  }

  _renderButton() {
    render(
        id,
        new Options(
            scope: scope,
            width: width == null ? null : int.parse(width),
            height: height == null ? null : int.parse(height),
            longtitle: _nullableParseBool(longTitle),
            theme: theme,
            onsuccess: allowInterop(
                (GoogleUser googleUser) => _handleSuccess(googleUser)),
            onfailure: allowInterop(() => _handleFailure())));
  }
}

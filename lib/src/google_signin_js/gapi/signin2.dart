@JS('gapi.signin2')
library gapi.signin2;

import 'package:js/js.dart';

@JS()
external void render(String id, Options options);

@JS()
@anonymous
class Options {
  external String get scope;

  external int get width;

  external int get height;

  external bool get longtitle;

  external String get theme;

  external Function get onsuccess;

  external Function get onfailure;

  external factory Options(
      {String scope,
      int width,
      int height,
      bool longtitle,
      String theme,
      Function onsuccess,
      Function onfailure});
}

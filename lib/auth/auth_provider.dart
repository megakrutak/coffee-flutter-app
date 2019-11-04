
abstract class AuthProvider {
  bool isAuthorized();
  String getAccessToken();
  String getBearer();
}

class AppAuthProvider implements AuthProvider {
  String _accessToken;
  String _bearer;

  AppAuthProvider(this._accessToken, this._bearer);

  @override
  String getAccessToken() {
    return _accessToken;
  }

  @override
  String getBearer() {
    return _bearer;
  }

  @override
  bool isAuthorized() {
    return (_accessToken != null);
  }
}
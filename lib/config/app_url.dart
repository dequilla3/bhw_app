class AppUrl {
  static String? _baseUrl;
  static String? _deviceUrl;

  static void setBaseUrl(String url) {
    _baseUrl = url;
  }

  static void setDeviceUrl(String url) {
    _deviceUrl = url;
  }

  static String getBaseUrl() {
    return _baseUrl!;
  }

  static String getDeviceUrl() {
    return _deviceUrl!;
  }
}

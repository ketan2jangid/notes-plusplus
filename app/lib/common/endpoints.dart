class Endpoints {
  // ***** BASE URL *****
  static const String baseUrl = "http://10.0.2.2:3000/";

  // ***** ROUTES *****
  static const String auth = "${baseUrl}auth/";
  static const String notes = "${baseUrl}notes/";

  // ***** ENDPOINTS *****

  // Authentication Endpoints
  static const String register = "register";
  static const String login = "login";

  // Notes Endpoints
  static const String getAll = "all";
}

class ApiEndpoints {
  //base url
  static const String baseUrl = "https://opentdb.com";

  //time out duration
  static const int receiveTimeout = 15000;
  static const int connectionTimout = 15000;

  //openDB endpoints
  static const openTdbCategoryUrl = "$baseUrl/api_category.php";
  static const openTdbquestionUrl = "$baseUrl/api.php";
}

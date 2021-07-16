class APIPath {
  static String exercise(String exerciseID) => "exercises/$exerciseID";
  static String exercises = "exercises";
  static String userData(String uid, String id) => "users/$uid/userData";
  static String exerciseLog(String uid, String id) =>
      "users/$uid/exerciseLog/$id";
  static String exercisesLog(String uid) => "users/$uid/exerciseLog";
}

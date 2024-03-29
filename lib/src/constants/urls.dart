/// List of the URLS used by the different services
class Urls {
  // Urls related to MonETS
  static const String monEtsAPI = "https://portail.etsmtl.ca/api/";
  static const String authenticationMonETS = "${monEtsAPI}authentification";

  /// Urls related to Hello API news endpoints
  /// TODO: Change the URL to the real one
  static const String helloNewsAPI = "9d80-192-226-141-106.ngrok-free.app";

  /// Urls related to SignetsMobile API
  /// For more information about the operations supported see:
  /// https://signets-ens.etsmtl.ca/Secure/WebServices/SignetsMobile.asmx
  static const String signetsAPI =
      "https://signets-ens.etsmtl.ca/Secure/WebServices/SignetsMobile.asmx";

  // SOAP Operations supported by the Signets API
  static const String signetsOperationBase = "http://etsmtl.ca/";
  static const String donneesAuthentificationValides =
      "donneesAuthentificationValides";
  static const String infoStudentOperation = "infoEtudiant";
  static const String listProgramsOperation = "listeProgrammes";
  static const String listClassScheduleOperation = "lireHoraireDesSeances";
  static const String listSessionsOperation = "listeSessions";
  static const String listCourseOperation = "listeCours";
  static const String listEvaluationsOperation = "listeElementsEvaluation";
  static const String listeHoraireEtProf = "listeHoraireEtProf";
  static const String readCourseReviewOperation = "lireEvaluationCours";
}

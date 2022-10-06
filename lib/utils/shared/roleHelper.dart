import 'package:firebasetest/utils/shared/constants.dart';

class RoleHelper {
  //admin
  //co-admin
  //planer
  //user

  static bool hasRights(AllRoles wantedRole) {
    if (wantedRole.index >= Constants.currentUser.role.index) {
      return true;
    } else {
      return false;
    }
  }

  static final List<String> roles = [
    "admin",
    "coAdmin",
    "planer",
    "user",
  ];
}

enum AllRoles {
  admin, //0
  coAdmin, //1
  planer, //2
  user, //3
}



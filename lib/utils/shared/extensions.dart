import 'package:firebasetest/utils/Models/member.dart';
import 'package:firebasetest/utils/shared/constants.dart';
import 'package:firebasetest/utils/shared/roleHelper.dart';

extension AllRolesHelper on AllRoles {
  /// Returns a [AllRoles] for a valid string representation, such as "if" or "class".
  static AllRoles toEnum(String asString) {
    var test = AllRoles.values.where((kw) => kw.name == asString).toList();

    if (test.isNotEmpty) {
      return test[0];
    } else {
      return AllRoles.user;
    }
  }
}

extension BirthdayHelper on BirthdayShowState {
  /// Returns a [AllRoles] for a valid string representation, such as "if" or "class".
  static BirthdayShowState toEnum(String asString) {
    try {
      var m =
          BirthdayShowState.values.where((kw) => kw.name == asString).toList();

      if (m.isNotEmpty) {
        return m[0];
      } else {
        return BirthdayShowState.no;
      }
    } catch (_) {
      throw _;
    }
  }
}

extension DateTimeHelper on DateTime {
  static String get data {
    return "";
  }
}

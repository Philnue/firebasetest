import 'package:firebasetest/utils/Models/member.dart';

class MemberDecision {
  MemberDecision(
      {required this.mitglied, required this.entscheidung, this.count = 0});

  final Member mitglied;
  final int entscheidung;
  final int count;

  String get getValueWithCount {
    return count == 0 ? mitglied.getName : mitglied.getName + " +$count";
  }

  int get intValueCount {
    return count == 0 ? 1 : count + 1;
  }
}

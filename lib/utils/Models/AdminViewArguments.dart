import 'package:firebasetest/utils/Models/memberDecision.dart';

class AdminViewArguments {
  final List<MemberDecision> memberDecisionList;
  final bool withAppendix;

  AdminViewArguments(this.memberDecisionList, this.withAppendix);


}

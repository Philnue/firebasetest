import 'package:firebasetest/utils/Models/member.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CrrtUserNotifier extends StateNotifier<Member> {
  CrrtUserNotifier(Member initValue) : super(initValue);

  void setUser(Member data) {}
}

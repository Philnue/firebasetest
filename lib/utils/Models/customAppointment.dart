import 'package:firebasetest/utils/Models/appointment.dart';

class CustomAppointment {
  final List<Appointment> appointmentList;
  bool isVisible;

  CustomAppointment({
    required this.appointmentList,
    required this.isVisible,
  });

  void toggleBool() {
    isVisible = !isVisible;
  }
}

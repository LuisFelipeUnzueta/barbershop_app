import 'package:barbershop_app/src/model/user_model.dart';

enum HomeAdmStateStatus { loaded, error }

class HomeAdmState {
  HomeAdmState({
    required this.status,
    required this.employees,
  });

  final HomeAdmStateStatus status;
  final List<UserModel> employees;

  HomeAdmState copyWith({
    HomeAdmStateStatus? status,
    List<UserModel>? employees,
  }) {
    return HomeAdmState(
      status: status ?? this.status,
      employees: employees ?? this.employees,
    );
  }
}

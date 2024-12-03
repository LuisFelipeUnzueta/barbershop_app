import 'package:barbershop_app/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop_app/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop_app/src/core/ui/widgets/weekdays_panel.dart';
import 'package:barbershop_app/src/features/employee/register/employee_register_state.dart';
import 'package:barbershop_app/src/features/employee/register/employee_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerAdm = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVM = ref.watch(employeeRegisterVmProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const AvatarWidget(),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      Checkbox.adaptive(value: registerAdm, onChanged: (value) {
                        setState(() {
                          registerAdm = !registerAdm;
                          employeeRegisterVM.setRegisterAdm(registerAdm);
                        });
                      }),
                      const Expanded(
                        child: Text(
                          'Sou administrador e quero me cadastrar como colaborador',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Offstage(
                    offstage: registerAdm,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(label: Text('Nome')),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(label: Text('E-mail')),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(label: Text('Senha')),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  WeekdaysPanel(onDayPressed: (String day) {}),
                  const SizedBox(
                    height: 24,
                  ),
                  HoursPanel(
                      startTime: 6, endTime: 23, onPressedHour: (int hour) {}),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(56)),
                    onPressed: () {},
                    child: const Text('CADASTRAR COLABORADOR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

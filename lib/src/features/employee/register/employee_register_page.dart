import 'dart:developer';

import 'package:barbershop_app/src/core/providers/aplication_providers.dart';
import 'package:barbershop_app/src/core/ui/helpers/form_helper.dart';
import 'package:barbershop_app/src/core/ui/widgets/avatar_widget.dart';
import 'package:barbershop_app/src/core/ui/widgets/barbershop_loader.dart';
import 'package:barbershop_app/src/core/ui/widgets/hours_panel.dart';
import 'package:barbershop_app/src/core/ui/widgets/weekdays_panel.dart';
import 'package:barbershop_app/src/features/employee/register/employee_register_state.dart';
import 'package:barbershop_app/src/features/employee/register/employee_register_vm.dart';
import 'package:barbershop_app/src/model/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

import '../../../core/ui/helpers/messages.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
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
    final BarbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Messages.showSuccess('Colaborador cadastrado com sucesso', context);
          Navigator.of(context).pop();
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao registrar colaborador', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Colaborador'),
      ),
      body: BarbershopAsyncValue.when(
        data: (barbershopModel) {
          final BarbershopModel(:openingDays, :openingHours) = barbershopModel;

          return SingleChildScrollView(
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
                          Checkbox.adaptive(
                              value: registerAdm,
                              onChanged: (value) {
                                setState(() {
                                  registerAdm = !registerAdm;
                                  employeeRegisterVM
                                      .setRegisterAdm(registerAdm);
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
                              decoration: const InputDecoration(
                                label: Text('Nome'),
                              ),
                              controller: nameEC,
                              onTapOutside: (_) => unfocus(context),
                              validator:
                                  Validatorless.required('Campo obrigatório'),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('E-mail'),
                                  hintText: 'E-mail',
                                  hintStyle: TextStyle(color: Colors.black),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelStyle: TextStyle(color: Colors.black)),
                              onTapOutside: (_) => unfocus(context),
                              validator: Validatorless.multiple([
                                Validatorless.required('E-mail obrigatório.'),
                                Validatorless.email('E-mail inválid'),
                              ]),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  label: Text('Senha'),
                                  hintText: 'Senha',
                                  hintStyle: TextStyle(color: Colors.black),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelStyle: TextStyle(color: Colors.black)),
                              onTapOutside: (_) => unfocus(context),
                              obscureText: true,
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatória'),
                                Validatorless.min(6,
                                    'Senha deve conter no mínimo 6 caracteres.')
                              ]),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      WeekdaysPanel(
                        onDayPressed: employeeRegisterVM.addOrRemoveWorkDays,
                        enabledDays: openingDays,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      HoursPanel(
                          startTime: 6,
                          endTime: 23,
                          enabledTimes: openingHours,
                          onPressedHour:
                              employeeRegisterVM.addOrRemoveWorkHours),
                      const SizedBox(
                        height: 24,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(56)),
                        onPressed: () {
                          switch (formKey.currentState?.validate()) {
                            case false || null:
                              Messages.showError(
                                  'Existem campos inválidos', context);
                            case true:
                              final EmployeeRegisterState(
                                :workDays,
                                :workHours
                              ) = ref.watch(employeeRegisterVmProvider);
                              if (workDays.isEmpty || workHours.isEmpty) {
                                Messages.showError(
                                    'Por favor selecione os dias da semana e horário de atendimento',
                                    context);
                                return;
                              }
                              employeeRegisterVM.register(
                                  nameEC.text, emailEC.text, passwordEC.text);
                          }
                        },
                        child: const Text('CADASTRAR COLABORADOR'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) {
          log('Erro aro carregar a página',
              error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar a página.'),
          );
        },
        loading: () => const BarbershopLoader(),
      ),
    );
  }
}

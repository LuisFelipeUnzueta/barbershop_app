import 'package:barbershop_app/src/core/ui/barbershop_icons.dart';
import 'package:barbershop_app/src/core/ui/constants.dart';
import 'package:barbershop_app/src/features/home/adm/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brown,
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(BarbershopIcons.addEmployee, color: ColorsConstants.brown,),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => null,
                childCount: 20),
          ),
        ],
      ),
    );
  }
}

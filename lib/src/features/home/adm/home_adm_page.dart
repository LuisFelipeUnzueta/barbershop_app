import 'package:barbershop_app/src/features/home/widgets/home_header.dart';
import 'package:flutter/material.dart';

class HomeAdmPage extends StatelessWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME ADM'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeHeader(),
          ),
        ],
      ),
    );
  }
}

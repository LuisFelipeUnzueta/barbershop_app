import 'package:barbershop_app/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: MediaQuery.sizeOf(context).width,
      height: 400,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(ImageConstants.backgroundChair),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child:  const Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xffbdbdbd),
                child: SizedBox.shrink(),
              ),
              SizedBox(
                width: 16,
              ),
              Flexible(
                child: Text(
                  'Andrea',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  'Editar',
                  style: TextStyle(
                    color: ColorsConstants.brown,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // 
              
            ],
          ),
        ],
      ),
    );
  }
}

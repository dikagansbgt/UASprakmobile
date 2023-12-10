import 'package:flutter/material.dart';
import 'package:mobile/profile.dart';
import 'package:mobile/rentalMobil.dart';
import 'package:mobile/menu.dart';

class CustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Menu();
                },
              ));
            },
            child: Icon(
              Icons.home,
              size: 35,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return RentalMobil();
                },
              ));
            },
            child: Icon(
              Icons.car_rental,
              size: 35,
              color: Colors.black,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return Profile();
                },
              ));
            },
            child: Icon(
              Icons.person,
              size: 35,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

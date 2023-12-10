import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                ),
                hintText: 'Cari',
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              child: Icon(
                Icons.mic_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

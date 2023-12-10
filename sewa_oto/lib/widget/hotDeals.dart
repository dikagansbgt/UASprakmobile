import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/detailRental.dart';

class HotDeals extends StatefulWidget {
  const HotDeals({super.key});

  @override
  State<HotDeals> createState() => _HotDealsState();
}

class _HotDealsState extends State<HotDeals> {
  var dataRental = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://my-community-d8ab0-default-rtdb.asia-southeast1.firebasedatabase.app/rental.json',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        // data.forEach((key, value) {
        //   dataRental.add(value);
        // });

        dataRental = data.values
            .where((value) => value['kategori'] == 'Hot Deals')
            .toList();
        setState(() {});
      } else {
        throw Exception(
            'Gagal mengambil data. Kode status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Hot Deals',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Octopus'),
            ),
            dataRental.isNotEmpty
                ? Container(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis
                          .horizontal, // Set the scroll direction to horizontal
                      itemCount: dataRental.length,
                      itemBuilder: (context, index) =>
                          ListHotDeals(dataRental: dataRental[index]),
                    ),
                  )
                : Container(
                    // Tampilkan widget loading atau pesan "Data belum diambil"
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(), // Atau widget lainnya
                  ),
          ],
        ));
  }
}

class ListHotDeals extends StatelessWidget {
  final dynamic dataRental;

  ListHotDeals({required this.dataRental});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailRental(dataRental: dataRental),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: 300, // Set the width for horizontal layout
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  dataRental['foto'],
                  width: 300,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataRental['rental'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.attach_money,
                          color: Colors.green[900],
                        ),
                        Text(
                          '${dataRental['harga']}/day',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

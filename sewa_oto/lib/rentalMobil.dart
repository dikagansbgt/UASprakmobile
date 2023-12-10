import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/detailRental.dart';
import 'package:mobile/widget/customNavBar.dart';
import 'package:http/http.dart' as http;

class RentalMobil extends StatefulWidget {
  const RentalMobil({super.key});

  @override
  State<RentalMobil> createState() => _RentalMobilState();
}

class _RentalMobilState extends State<RentalMobil> {
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
        data.forEach((key, value) {
          dataRental.add(value);
        });

        // dataRental = data.values.toList();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Pilihan Rental Mobil"),
        backgroundColor: Color.fromARGB(255, 155, 151, 137),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: dataRental.isNotEmpty
                  ? ListView.builder(
                      padding: EdgeInsets.only(top: 15),
                      itemCount: dataRental.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailRental(dataRental: dataRental[index]),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 110,
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 155, 151, 137),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      dataRental[index]['foto'],
                                      height: 100,
                                      width: 130,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        dataRental[index]['rental'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        dataRental[index]['mobil'],
                                        style: TextStyle(
                                          color: Colors.white54,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.attach_money,
                                            color: Colors.green[900],
                                          ),
                                          Text(
                                            dataRental[index]['harga'],
                                            style: TextStyle(
                                              color: Colors.white54,
                                              // fontSize: 16,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 23,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Container(
                      // Tampilkan widget loading atau pesan "Data belum diambil"
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(), // Atau widget lainnya
                    ),
            ),
          ],
        ),
      ),
      // body: ListView.builder(
      //   itemCount: numberList.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     final data = soundIndex[index];
      //     return Card(
      //       elevation: 5, // Add elevation for a card-like appearance
      //       margin: EdgeInsets.all(10), // Add margin for spacing
      //       child: ListTile(
      //         leading: Container(
      //           width: 80,
      //           height: 80,
      //           child: Image.asset(data.foto),
      //         ),
      //         title: Text(data.jenis),
      //         subtitle: Text(data.harga),
      //         onTap: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) {
      //               return DetailRental(data: data);
      //             },
      //           ));
      //         },
      //       ),
      //     );
      //   },
      // ),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}

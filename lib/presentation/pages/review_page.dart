import 'package:flutter/material.dart';

import '../../logic/models/KTP.dart';
import 'home_page.dart';

class ReviewPage extends StatelessWidget {
  final KTP ktp;

  const ReviewPage({super.key, required this.ktp});

  static const routeName = '/reviewPage';

  @override
  Widget build(BuildContext context) {
    // make list of controller for each text field
    final Map<String, TextEditingController> controllers = {
      'NIK': TextEditingController(text: ktp.nik),
      'Nama': TextEditingController(text: ktp.nama),
      'Tempat Lahir': TextEditingController(text: ktp.tempatLahir),
      'Tanggal Lahir': TextEditingController(text: ktp.tanggalLahir),
      'Jenis Kelamin': TextEditingController(text: ktp.jenisKelamin),
      'Gol. Darah': TextEditingController(text: ktp.golDarah),
      'Alamat': TextEditingController(text: ktp.alamat),
      'Agama': TextEditingController(text: ktp.agama),
      'Status Perkawinan': TextEditingController(text: ktp.statusPerkawinan),
      'Pekerjaan': TextEditingController(text: ktp.pekerjaan),
      'Kewarganegaraan': TextEditingController(text: ktp.kewarganegaraan),
    };

    return Scaffold(
      appBar: AppBar(title: Text('Review Data')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: controllers
                    .map(
                      (key, value) {
                        return MapEntry(
                          key,
                          TextField(
                            controller: value,
                            decoration: InputDecoration(
                              labelText: key,
                            ),
                          ),
                        );
                      },
                    )
                    .values
                    .toList(),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
                },
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

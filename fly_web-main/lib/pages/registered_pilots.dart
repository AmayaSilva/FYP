import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fly_web/pages/login.dart';

import '../widgets/button_widget.dart';

class RegisteredPilotsPage extends StatefulWidget {
  static const routeName = '/registered-pilots';

  const RegisteredPilotsPage({Key? key}) : super(key: key);

  @override
  State<RegisteredPilotsPage> createState() => _RegisteredPilotsPageState();
}

class _RegisteredPilotsPageState extends State<RegisteredPilotsPage> {
  // List<Map<String, dynamic>> results = [
  //   {
  //     "AtcoId": "1",
  //     "name": "John Doe",
  //     "tower": "BIA tower",
  //     "contact": "1234567890",
  //   },
  //   {
  //     "AtcoId": "2",
  //     "name": "Jane Doe",
  //     "tower": "Ratmalana tower",
  //     "contact": "1234567890",
  //   },
  //   {
  //     "AtcoId": "3",
  //     "name": "Bruce Wayne",
  //     "tower": "Kandy tower",
  //     "contact": "1234567890",
  //   },
  // ];
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMedicine(String id) {
    final ref = FirebaseFirestore.instance
        .collection("atcos")
        .doc(atcid)
        .collection(_subCollectionName);

    if (id.isNotEmpty) {
      return ref.where('medID', isEqualTo: id).snapshots();
    }
    return ref.snapshots();
  }

  Widget _buildTable() {
    // build table view
    const TextStyle titleStyle =
        TextStyle(fontSize: 14, fontWeight: FontWeight.bold);

    return StreamBuilder(
      stream: _medicineController.fetchMedicine(_searchController.text),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }

        final List<MedicineModel> _medicines = snapshot.data?.docs
                .map((e) => MedicineModel.fromJson(e.data()))
                .toList() ??
            [];

        if (_medicines.isEmpty) {
          return const Center(child: Text("No Medicines"));
        }
        return DataTable(
            showCheckboxColumn: false,
            border: TableBorder.symmetric(
              outside: BorderSide(color: _backgroundColor),
            ),
            headingRowColor:
                MaterialStateColor.resolveWith((states) => Colors.white),
            dataRowColor:
                MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
            columns: const [
              DataColumn(label: Text("ID", style: titleStyle)),
              DataColumn(label: Text("Name", style: titleStyle)),
              //brand
              DataColumn(label: Text("Brand", style: titleStyle)),
              //dose
              DataColumn(label: Text("Dose", style: titleStyle)),
              DataColumn(label: Text("Quantity", style: titleStyle)),
              DataColumn(label: Text("Price", style: titleStyle)),
            ],
            rows: [
              for (final medicine in _medicines)
                DataRow(
                  selected: _selectedMedicine == medicine,
                  onSelectChanged: _tabIndex != 1
                      ? null
                      : (value) {
                          if (mounted) {
                            setState(() {
                              _selectedMedicine =
                                  value == true ? medicine : null;
                            });
                          }
                        },
                  cells: [
                    DataCell(Text(medicine.medID ?? '')),
                    DataCell(Text(medicine.medName ?? '')),
                    DataCell(Text(medicine.brand ?? '')),
                    DataCell(Text(medicine.dose ?? '')),
                    DataCell(Text(medicine.quantity?.toString() ?? '')),
                    DataCell(Text(medicine.price?.toStringAsFixed(2) ?? '')),
                  ],
                ),
            ]);
      },
    );
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                children: [
                  const Text(
                    'Details of registered air traffic controllers',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Theme.of(context).primaryColor),
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text(
                            'ATCO license ID',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Name (Profile)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Tower',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Contact',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        results.length,
                        (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(results[index]['AtcoId'])),
                            DataCell(Text(results[index]['name'])),
                            DataCell(Text(results[index]['tower'])),
                            DataCell(Text(results[index]['contact'])),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: ButtonWidget(
                      margin: const EdgeInsets.only(left: 20),
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginPage.routeName,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'LOG OUT',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
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

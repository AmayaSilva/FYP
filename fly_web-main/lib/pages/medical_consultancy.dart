import 'package:flutter/material.dart';

import '../widgets/button_widget.dart';
import 'login.dart';

class MedicalConsultancyPage extends StatefulWidget {
  static const routeName = '/medical-consultancy';

  const MedicalConsultancyPage({Key? key}) : super(key: key);

  @override
  State<MedicalConsultancyPage> createState() => _MedicalConsultancyPageState();
}

class _MedicalConsultancyPageState extends State<MedicalConsultancyPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  List<Map<String, dynamic>> consultancy = [
    {
      "AtcoId": "1",
      "name": "John Doe",
      "date": "2020-01-01",
      "time": "11:00",
      "suitability": 0.7,
      "requested": true,
      "consulted": true,
    },
    {
      "AtcoId": "2",
      "name": "Jane Doe",
      "date": "2020-01-02",
      "time": "08:00",
      "suitability": 0.8,
      "requested": false,
      "consulted": false,
    },
    {
      "AtcoId": "3",
      "name": "Bruce Wayne",
      "date": "2020-01-03",
      "time": "09:00",
      "suitability": 0.85,
      "requested": true,
      "consulted": true,
    },
  ];

  String filterId = "";
  List<Map<String, dynamic>> filteredConsultancy = [];

  void filterConsultancy() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        filteredConsultancy = consultancy
            .where((element) => element["AtcoId"] == filterId)
            .toList();
      });
    }
  }

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
                    'Medical Consultancy',
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
                            'Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Time',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Suitability to work',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Medical Officer consultation requested or not',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Medical Officer consulted or not',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        consultancy.length,
                        (index) => DataRow(
                          cells: <DataCell>[
                            DataCell(Text(consultancy[index]['AtcoId'])),
                            DataCell(Text(consultancy[index]['name'])),
                            DataCell(Text(consultancy[index]['date'])),
                            DataCell(Text(consultancy[index]['time'])),
                            DataCell(Text(
                                "${(consultancy[index]['suitability'] * 100).toString()}%")),
                            DataCell(
                              Checkbox(
                                value: consultancy[index]['requested'],
                                onChanged: (value) {
                                  setState(() {
                                    consultancy[index]['requested'] = value;
                                  });
                                },
                              ),
                            ),
                            DataCell(
                              Checkbox(
                                value: consultancy[index]['consulted'],
                                onChanged: (value) {
                                  setState(() {
                                    consultancy[index]['consulted'] = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Filter by license ID",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            onSaved: (value) {
                              setState(() {
                                filterId = value!;
                              });
                            },
                            validator: (value) => value == ""
                                ? 'Please enter a ATCO license ID'
                                : null,
                            decoration: InputDecoration(
                              filled: true,
                              labelText:
                                  "Enter ATCO license ID to view past records",
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                        child: ButtonWidget(
                          margin: const EdgeInsets.only(left: 20),
                          onTap: filterConsultancy,
                          child: const Text(
                            'SEARCH',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  filteredConsultancy.isNotEmpty
                      ? Center(
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
                                  'Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Time',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Suitability to work',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Medical Officer consultation requested or not',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Medical Officer consulted or not',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                            rows: List.generate(
                              filteredConsultancy.length,
                              (index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(
                                      filteredConsultancy[index]['AtcoId'])),
                                  DataCell(
                                      Text(filteredConsultancy[index]['name'])),
                                  DataCell(Text(consultancy[index]['date'])),
                                  DataCell(Text(consultancy[index]['time'])),
                                  DataCell(
                                    Checkbox(
                                      value: filteredConsultancy[index]
                                          ['suitability'],
                                      onChanged: (value) {
                                        setState(() {
                                          filteredConsultancy[index]
                                              ['suitability'] = value;
                                        });
                                      },
                                    ),
                                  ),
                                  DataCell(
                                    Checkbox(
                                      value: filteredConsultancy[index]
                                          ['requested'],
                                      onChanged: (value) {
                                        setState(() {
                                          filteredConsultancy[index]
                                              ['requested'] = value;
                                        });
                                      },
                                    ),
                                  ),
                                  DataCell(
                                    Checkbox(
                                      value: filteredConsultancy[index]
                                          ['consulted'],
                                      onChanged: (value) {
                                        setState(() {
                                          filteredConsultancy[index]
                                              ['consulted'] = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 50),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextFormField(
                            onSaved: (value) {},
                            validator: (value) => value == ""
                                ? 'Please enter a ATCO license ID'
                                : null,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: "Enter ATCO license ID for consulting",
                              fillColor: Colors.white,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: ButtonWidget(
                            onTap: () {},
                            child: const Text(
                              'CONTACT',
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
                  const SizedBox(height: 150),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: ButtonWidget(
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

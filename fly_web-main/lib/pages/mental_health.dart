import 'package:flutter/material.dart';
import 'package:fly_web/pages/login.dart';
import 'package:fly_web/pages/registered_pilots.dart';
import 'package:fly_web/widgets/button_widget.dart';

class MentalHealthPage extends StatefulWidget {
  static const routeName = '/mental-health';

  const MentalHealthPage({Key? key}) : super(key: key);

  @override
  State<MentalHealthPage> createState() => _MentalHealthPageState();
}

class _MentalHealthPageState extends State<MentalHealthPage> {
  List<Map<String, dynamic>> results = [
    {
      "AtcoId": "1",
      "name": "John Doe",
      "date": "2020-01-01",
      "time": "11:00",
      "suitability": 0.7,
      "consulted": true,
    },
    {
      "AtcoId": "2",
      "name": "Jane Doe",
      "date": "2020-01-02",
      "time": "08:00",
      "suitability": 0.8,
      "consulted": false,
    },
    {
      "AtcoId": "3",
      "name": "Bruce Wayne",
      "date": "2020-01-03",
      "time": "09:00",
      "suitability": 0.85,
      "consulted": true,
    },
  ];

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
                    'Mental Health of the pilots and medical officer\'s consultation',
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
                            'Medical Officer consulted or not',
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
                            DataCell(Text(results[index]['date'])),
                            DataCell(Text(results[index]['time'])),
                            DataCell(Text(
                                "${(results[index]['suitability'] * 100).toString()}%")),
                            DataCell(
                              Checkbox(
                                value: results[index]['consulted'],
                                onChanged: (value) {
                                  setState(() {
                                    results[index]['consulted'] = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ButtonWidget(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RegisteredPilotsPage.routeName);
                          },
                          child: const Text(
                            'REGISTERED AIR TRAFFIC CONTROLLERS',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

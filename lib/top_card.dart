import 'package:flutter/material.dart';
import 'package:rbctruck/google_sheet_api.dart';

class TopMeuCard extends StatelessWidget {
  final String balance;
  final String KmTotal;
  final String LitrosTotal;

  TopMeuCard(
      {super.key,
      required this.KmTotal,
      required this.LitrosTotal,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.all(10.0),
      child:  Container(

        decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(15),
            color: Colors.blue[300],
            boxShadow: [
              BoxShadow(
                  offset:  Offset(4.0, 4.0),
                  color: Colors.blue.shade700,
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  offset: Offset(-4.0, -4.0),
                  color: Colors.grey.shade400,
                  blurRadius: 15.0,
                  spreadRadius: 1.0),
            ]),
        height: 180,

        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'MÉDIA  KM/H',
                    style: TextStyle(color: Colors.blue[900], fontSize: 16),
                  ),
                ),
                Text(
                   balance,
                  style: TextStyle(color: Colors.blue[800], fontSize: 40),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue[200],
                        ),
                        child: Center(
                          child: Icon(
                            Icons.arrow_upward_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Total Km",style: TextStyle(color: Colors.blue[900]),),
                              Text(KmTotal),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blue[200],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.arrow_upward_outlined,
                                    color: Colors.green,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Total Litros", style: TextStyle(color: Colors.blue[900]),),
                                Text(LitrosTotal),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

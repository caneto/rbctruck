import 'package:flutter/material.dart';


class TopMeuCard extends StatelessWidget {
  final String balance;
  final String KmTotal;
  final String LitrosTotal;
  final String totalDinheiro;

  TopMeuCard(
      {super.key,
        required this.totalDinheiro,
      required this.KmTotal,
      required this.LitrosTotal,
      required this.balance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blue[300],
            boxShadow: [
              BoxShadow(
                  offset: Offset(4.0, 4.0),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      double.parse(balance) < 3.49
                          ? Icons.arrow_drop_down_circle_sharp
                          : (double.parse(balance) > 3.49
                              ? Icons.arrow_circle_up
                              : Icons.hourglass_empty),
                      color: double.parse(balance) < 3.49
                          ? Colors.red
                          : (double.parse(balance) > 3.49
                              ? Colors.green
                              : Colors.black),
                    ),
                    Text(
                      balance,
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Total Km",
                                style: TextStyle(color: Colors.blue[900]),
                              ),
                              Text('km ' + KmTotal),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Litros",
                                  style: TextStyle(color: Colors.blue[900]),
                                ),
                                Text('LT '+  LitrosTotal),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Gasto",
                                  style: TextStyle(color: Colors.blue[900]),
                                ),
                                Text("R\$ " +totalDinheiro),
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

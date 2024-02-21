import 'package:flutter/material.dart';

class MyTransation extends StatelessWidget {
  final String transationMotorista;
  final String transationValor;
  final String transationCaminhao;
  final String transationKmInicial;
  final String transationKmFinl;
  final String transationLitros;
  //final DateTime dateTime;

  //final String dinheiro;
  //final String AbastecimentoOrManutencao;

  const MyTransation({
    super.key,
    required this.transationMotorista,
    required this.transationValor,
    required this.transationCaminhao,
    required this.transationKmInicial,
    required this.transationKmFinl,
    required this.transationLitros,
   // required this.dateTime,
    //required this.AbastecimentoOrManutencao,
    //required this.dinheiro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRect(
                child: Container(
                  color: Colors.blue[200],
                  height: 50,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Center(
                                child: Icon(Icons.monetization_on),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(transationMotorista),
                            ),
                          ],
                        ),
                        Text(
                          transationLitros,
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

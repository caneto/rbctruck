import 'package:flutter/material.dart';
import 'package:rbctruck/google_sheet_api.dart';

class MyTransation extends StatefulWidget {
  final String transationMotorista;
  final String transationLitros;
  final String transationValor;
  final String transationCaminhao;
  final String transationKmInicial;
  final String transationKmFinal;
  final String transactionMediaViagem;
  final String transactionprecoBomba;
  final String transationKmTotal;

  MyTransation({
    super.key,
    required this.transactionprecoBomba,
    required this.transationKmTotal,
    required this.transactionMediaViagem,
    required this.transationMotorista,
    required this.transationValor,
    required this.transationCaminhao,
    required this.transationKmInicial,
    required this.transationKmFinal,
    required this.transationLitros,
  });

  @override
  State<MyTransation> createState() => _MyTransationState();
}

class _MyTransationState extends State<MyTransation> {
  bool showDetails = false;

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
                        Row(mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                shape: BoxShape.circle,
                                color: Colors.blue.shade500,
                              ),
                              child: Center(
                                child: Text(
                                  '${double.parse(widget.transactionMediaViagem).toStringAsFixed(2)}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16.0),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(widget.transationMotorista),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showDetails = !showDetails;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRect(
                              child: Container(
                                height: 50,
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.visibility_outlined),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: showDetails ? 200 : 0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Motorista: ${widget.transationMotorista}"),
                    Text("Total Reais: R\$ ${widget.transationValor}"),
                    Text("Placa: ${widget.transationCaminhao}"),
                    Text("Km Inicial: ${widget.transationKmInicial}"),
                    Text("Km Final: ${widget.transationKmFinal}"),
                    Text("Litros Abastecidos: ${widget.transationLitros}"),
                    Text('Km Total: ${widget.transationKmTotal}'),
                    Text(
                        'Media Vigem: ${double.parse(widget.transactionMediaViagem).toStringAsFixed(2)}'),
                    Text(
                        'Preço Diesel: ${double.parse(widget.transactionprecoBomba).toStringAsFixed(2)}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:rbctruck/google_sheet_api.dart';
import 'package:rbctruck/loading_circle.dart';
import 'package:rbctruck/plus_button.dart';
import 'package:rbctruck/top_card.dart';
import 'package:rbctruck/transation.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //metodo de entrta na transação
  void _entrarTransaction() {
    GoogleSheetApi.insert(
      _textcontrollerMotorista.text,
      _textcontrollerValor.text,
      _textcontrollerCaminhao.text,
      _textcontrollerKmInicial.text,
      _textcontrollerKmFinal.text,
      _textcontrollerLitros.text

      //_isIncome,
    );
    setState(() {});
  }

  //controladores do imput

  final _textcontrollerCaminhao = TextEditingController();
  final _textcontrollerValor = TextEditingController();
  final _textcontrollerKmInicial = TextEditingController();
  final _textcontrollerKmFinal = TextEditingController();
  final _textcontrollerLitros = TextEditingController();
  final _textcontrollerMotorista = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _isIncome = false;

  //nova transcao
  void _newTransaction() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return SingleChildScrollView(
              child: AlertDialog(
                title: const Text('NOVA TRANSAÇÃO'),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                  TextFormField(
                    initialValue: obterDataFormatada(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Data',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'MOTORISTA',
                              ),
                              keyboardType: TextInputType.text,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Digite nome do motorista';
                                }
                                return null;
                              },
                              controller: _textcontrollerMotorista,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: TextFormField(
                                inputFormatters: <TextInputFormatter>[
                                  PlacaVeiculoInputFormatter(),
                                ],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'CAMINHÃO',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Digite o caminhão';
                                  }
                                  return null;
                                },
                                controller: _textcontrollerCaminhao,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'KM INICIAL',
                              ),
                              keyboardType: const TextInputType.numberWithOptions(),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Digite o km inicial';
                                }
                                return null;
                              },
                              controller: _textcontrollerKmInicial,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'KM FINAL',
                              ),
                              keyboardType: const TextInputType.numberWithOptions(),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Digite o km final';
                                }
                                return null;
                              },
                              controller: _textcontrollerKmFinal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'LITROS',
                              ),
                              keyboardType: const TextInputType.numberWithOptions(),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Digite a quantidade de litros abastecido';
                                }
                                return null;
                              },
                              controller: _textcontrollerLitros,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'VALOR',
                              ),
                              keyboardType: const TextInputType.numberWithOptions(),
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Digite a valor abastecido';
                                }
                                return null;
                              },
                              controller: _textcontrollerValor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  MaterialButton(
                      color: Colors.blue[600],
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  MaterialButton(
                      color: Colors.blue[600],
                      child: const Text(
                        'Entrar',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (_formKey.currentState!.validate()) {
                          _entrarTransaction();
                        }
                        {}
                      }),
                ],
              ),
            );
          });
        });
  }

  bool timerHasStarted = false;

  void startLoading() {
    timerHasStarted = true;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetApi.loading == false) {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GoogleSheetApi.loading == true && timerHasStarted == false) {
      startLoading();
    }
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: <Widget>[
              TopMeuCard(
                balance: (GoogleSheetApi.getMediaTotal()).toStringAsFixed(2),
                litrosTotal: GoogleSheetApi.calculoLt().toStringAsFixed(2),
                kmTotal: GoogleSheetApi.calculoDis().toString(),
                totalDinheiro: GoogleSheetApi.getValorTotal().toStringAsFixed(2),
              ),
              Expanded(
                child: GoogleSheetApi.loading == true
                    ? const LoadingCircle()
                    : ListView.builder(
                        itemCount: GoogleSheetApi.currentTransactions.length,
                        itemBuilder: (context, index) {
                          return MyTransation(
                            transationMotorista:
                                GoogleSheetApi.currentTransactions[index][0],
        
                            transationValor:
                                GoogleSheetApi.currentTransactions[index][1],
        
                            transationCaminhao:
                                GoogleSheetApi.currentTransactions[index][2],
        
                            transationKmInicial:
                                GoogleSheetApi.currentTransactions[index][3],
        
                            transationKmFinal:
                                GoogleSheetApi.currentTransactions[index][4],
        
                            transationLitros:
                                GoogleSheetApi.currentTransactions[index][5],
        
                            transationKmTotal:
                            (GoogleSheetApi.currentTransactions[index][6]).toString(),
        
                            transactionMediaViagem:
                            (GoogleSheetApi.currentTransactions[index][7]).toString(),
        
                            transactionprecoBomba:
                            (GoogleSheetApi.currentTransactions[index][8]).toString(),
        
                            //AbastecimentoOrManutencao:
                            //GoogleSheetApi.currentTransactions[index][6],
                          );
                        }),
              ),
              PlusButton(
                function: _newTransaction,
              ),
            ],
          ),
        ),
      ),
    );
  }
  String obterDataFormatada() {
    // Obter data atual
    DateTime dataAtual = DateTime.now();

    // Formatar data
    String dataFormatada = DateFormat('dd/MM/yyyy').format(dataAtual);

    // Retornar data formatada
    return dataFormatada;
  }



}

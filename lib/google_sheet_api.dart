import 'package:gsheets/gsheets.dart';

class GoogleSheetApi {
  //credencias
  //codigo jhonsn GoogleSheets

  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "fluttergsheets-414417",
  "private_key_id": "23ac3aacd6494f0094f232447ee31b0d0a18751c",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCR8StrcwFcIMUz\noPd4aWht7z/MqWl+QtxvAbSgdFuVunJwo2m5zwMeZy78ISAt5qKBNporGR6aMpTE\nFVijNQsL6gtUESa0x7C19WCcC7xZsLWIa+uOEr+nspsblh0DQ/1okM2vGWZvXZ36\njCI35s4bxRZcoiTB7ZouvWA4QAOp5KzQdfe4YcJOWJSLg93fwliMKxtIrJXef+H3\n1e6mn1IPbg6iSVMHdJLNB192Em7goCIFXBlMCkpVs3ISwQvAR+YJVeSj9oJ1Jiow\nevggsCN3HFk7RP1kS8pRFlPrwNKJVFJahLBDD04mLoS/CduQ9GYvi8OFtuWpxUOy\nZy1tLgt7AgMBAAECggEAAv0odLCyeqHx+y1OkPjy4MWBZ5fUoREne8W4keZJwrBC\npb62OWfDwMlzAEqBYs9FZrx1vdcFQtOXkZVKVaIn3sLLucxvUxmzEcoiHcmgiuNM\n/hIPwFiIwLUUt76ES5igRclcnQhtI6Mly1Rq/JaA6oRHzlyq86abfZEqH+mXtmpm\nzMV5sqsZogJFLoYW8sIz05/z8/A9fxzOXxNhcX2VU7hnqQU2ErX0VYII2a7UArCU\nmXzcV4/bShxLxhH8jgziT45oumC1WSXMM8EuCmfg5KCiDforE4imrMcDOP9E9zwX\nySPORCZSh6qd/Y6vG1/pJW+LshK3FSZ1/Vmdv/C1QQKBgQDG/bBeJ6GF0CM/IipR\nOUghLeMPXbkolBUBc+XgDAzsl2Mpd8qGSSA2E0NsaKuN73DjWOi++k3gVtsGRR56\n7+/v4SOi/+RuUq9624si7hXUW8dVIAG1qhTUkQ4Uyhpy3g2SAuEQGPVBMTGYe66X\n7OR0+7LIYmkLjUqdPr7p2rp0WwKBgQC7wMpkoQouxxYX9Xxc/xAFDE8R2eaaY3+J\nTBnENHL13wMxffIi7k/3gvSEhSDS/wiMIsTdpxuUTlhZCq096jMLF3ch8Z16vNBg\nYMQA6oWJ3rtPD+QOhs6qjuvT3LOxoCojP+Appv64/8Fdmcgo45xV9QqL0sZw5CXT\nAS3VVmXvYQKBgQCq5ur4kpT49h+vc0pg5A9834opglcp8LRxwPZnDDJ1aDe0P7vi\nxR8zEixQCT19821C9PNAQn1r9Wy639Yjw7qQjQ4sShYIYl9v5uqCn3SEJCb4hzqw\nqVimj8ZGOKWqjeedxXdCegz5ZqSvz1nOBZjYl+ueilapozm3/1G8SyzkDQKBgGYT\nBHX9D3orBpnz/q7YhK8Z6Ar+el7JZVcRppiDI1UE78mCfZf8FEGuUp2Reyz7Nnxp\nkrom1dmlVmbiZRlaMHIBSeWMZF+MM4WSVj1hQ0SXcSIks4oqREV5+kBupssVFpOf\ncJF0ltuhQFFQ//8q753T4O3vo69QejfjVjW8CSNBAoGBAJLUqRU3PRHP+rRKQlub\n74h4FCwbEM4r1TrXzJ5RrhnXZCN2GFSYaO52bUAK+JIkDfUfhQUrizKs1l2IUKFv\nAxCbGzdAdjWgQmSPY0gny8J/dDRCugxS0t5wmDmjzrtDxwzJc535PB9ls685FLAQ\no4G/GF5PEZKJOPs7E3R8mA1b\n-----END PRIVATE KEY-----\n",
  "client_email": "fluttergsheets@fluttergsheets-414417.iam.gserviceaccount.com",
  "client_id": "109523868347277405847",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttergsheets%40fluttergsheets-414417.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
''';

//spreedsheet
  static const _spreadsheetId = '1Df_6DX-BzBJIidQcUySjTsd6XdATHWFT3H9jG8T4TZQ';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    loadTransactions();
  }

  static Future loadTransactions() async {
    if (_worksheet == null) return;
    for (int i = 1; i < numberOfTransactions; i++) {

      final String transactionMotorista =
          await _worksheet!.values.value(column: 1, row: i + 1);


      final String transactionValor =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionCaminhao =
          await _worksheet!.values.value(column: 3, row: i + 1);

      final String transactionKmInicial =
          await _worksheet!.values.value(column: 4, row: i + 1);

      final String transactionKmFinal =
          await _worksheet!.values.value(column: 5, row: i + 1);

      final String transactionLitros =
          await _worksheet!.values.value(column: 6, row: i + 1);

      final String transactionKmTotal =
      await _worksheet!.values.value(column: 7, row: i + 1);

      final String transactionMediaViagem =
      await _worksheet!.values.value(column: 8, row: i + 1);

      final String transactionprecoBomba =
      await _worksheet!.values.value(column: 9, row: i + 1);


//esse final strig trabsationType si refere ao km total insirio na planilha
      //final String transactionType =
          //await _worksheet!.values.value(column: 7, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionMotorista,
          transactionValor,
          transactionCaminhao,
          transactionKmInicial,
          transactionKmFinal,
          transactionLitros,
          transactionKmTotal,
          transactionMediaViagem,
          transactionprecoBomba,

        ]);
      }
    }
    loading = false;
  }

  //metodo de insert
  static Future insert(
    String motorista,
    String valor,
    String caminhao,
    String kmInicial,
    String kmFinal,
    String litros,
    //bool _isIncome,
  ) async {
    numberOfTransactions++;
    //final kmFinalDouble = double.parse(kmFinal);
    final kmFinalDouble = double.tryParse(kmFinal.replaceAll(",", ".")) ?? 0.0;
    final kmInicialDouble = kmInicial != ''
        ? double.tryParse(kmInicial.replaceAll(",", ".")) ?? 0.0
        : 0;
    //final kmInicialDouble = kmInicial != '' ? double.parse(kmInicial) : 0;
    final totalKm = kmFinalDouble - kmInicialDouble;

    //dinheiro divido por litro para ter o valor do litro
    final valorDouble = double.tryParse(valor.replaceAll(",", ".")) ?? 0.0;
    final litrosDouble = valor !=''? double.tryParse(litros.replaceAll(",", ".")) ?? 0.0
        : 0;
    final precoBomba = valorDouble /  litrosDouble ;

    currentTransactions.add([
      motorista,
      valor,
      caminhao,
      kmInicial,
      kmFinal,
      litros,
      totalKm,
      getMediaTotal(),
      precoBomba,

      //_isIncome == true ? 'Manutencao' : 'Abastecimento',
    ]);
    await _worksheet!.values.appendRow([
      motorista,
      valor,
      caminhao,
      kmInicial,
      kmFinal,
      litros,
      totalKm,
      getMediaTotal(),
      precoBomba,

      //_isIncome == true ? 'Manutencao' : 'Abastecimento',
    ]);
  }

//metodo para calcular a quanitdade de km percorrido.
  static double calculoDis() {
    double totalKm = 0;
    for (var transaction in currentTransactions) {
      final kmFinal =
          double.tryParse(transaction[4].replaceAll(",", ".")) ?? 0.0;
      final kmInicial = transaction[3] != ''
          ? double.tryParse(transaction[3].replaceAll(",", ".")) ?? 0.0
          : 0;
      totalKm += kmFinal - kmInicial;
    }
    return totalKm;
  }

//função para calcular a quantidade de litros consumidos
  static double calculoLt() {
    double totalLitros = 0;
    for (var transaction in currentTransactions) {
      totalLitros +=
          double.tryParse(transaction[5].replaceAll(",", ".")) ?? 0.0;
      //totalLitros += double.parse(transaction[5]);
    }
    return totalLitros;
  }

  //calculo para obter o total de dinheiro em bsteciemento
  static double calculoDinheitoTolat() {
    print(calculoDinheitoTolat);
    double totalDinheiro = 0;
    for (var transaction in currentTransactions) {
      totalDinheiro +=
          double.tryParse(transaction[1].replaceAll(",", ".")) ?? 0.0;
      //calculoDinheitoTolat += double.parse(transaction[5]);
    }
    return totalDinheiro;
  }

  //funçõ para calculr a media total
  static double getMediaTotal() {
    if (calculoLt() == 0) {
      return 0;
    }
    return calculoDis() / calculoLt();
  }

  //nova função para obter o a media da viagem

  //função para calcular o prço do combustivel
  static double calcularPrecoCombustivel(double valor, double litros) {
    if (valor <= 0 || litros <= 0) {
      return 0.0;
    }
    return valor / litros;
  }

//recuperando os texto digitados
}

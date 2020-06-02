class UtilsDate {

  List<String> _monthReduceExtension = [
    "Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"
  ];

  List<String> _monthFullExtension = [
    "Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto",
    "Setembro","Outubro","Novembro","Dezembro"
  ];

  String monthReduceExtension(int _month) {
    return _monthReduceExtension[_month];
  }

  String monthFullExtension(int _month) {
    return _monthFullExtension[_month];
  }

}
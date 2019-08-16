class Util{

  

    static String getDataServIni(){

        return "1984/12/23 00:00:00";
    }



  static String formatarNumero(double n) {
    if (n == null) {
      n = 0.0;
    }

    return n.toStringAsFixed(n.truncateToDouble() == n ? 2 : 2);
  }

  static String formatarNumeroRS(double n) {
    if (n == null) {
      n = 0.0;
    }

    String s = "\$";
    return "R" + s + " " + n.toStringAsFixed(n.truncateToDouble() == n ? 2 : 2);
  }

  static String formatarNumeroInt(int n) {
    if (n == null) {
      n = 0;
    }

    return n.toStringAsFixed(n.truncateToDouble() == n ? 1 : 1);
  }

  static String extrairNumeros(String valor) {
    String valorTemp = "";

    if (valor == null) {
      return null;
    }

    String valorRef = valor;

    String valorNumerico = "";

    while (valorRef != null && valorRef.isNotEmpty) {
      try {
        int numero = int.parse(valorRef[0]);
        valorNumerico += numero.toString();
      } catch (e) {}

      if (valorRef.length > 1) {
        valorRef = valorRef.substring(1);
      } else {
        valorRef = "";
      }
    }

    return valorNumerico;
  }


  static DateTime getDataHoraInicio(DateTime d){
    return new DateTime(d.year, d.month, d.day, d.hour, 0, 0);
  } 

  static DateTime getDataHoraFim(DateTime d){
    return new DateTime(d.year, d.month, d.day, d.hour, 59, 59);
  } 


  static DateTime getDataHoraInicioDia(DateTime d){
    return new DateTime(d.year, d.month, d.day, 0, 0, 0);
  } 

  static DateTime getDataHoraFimDia(DateTime d){
    return new DateTime(d.year, d.month, d.day, 23, 59, 59);
  } 



  static bool dataIgual(DateTime data1, DateTime data2) {
    if (data1.day == data2.day &&
        data1.month == data2.month &&
        data1.year == data2.year) {
      return true;
    }

    return false;
  }

  static bool dataMaior(DateTime data1, DateTime data2) {
    if (data1.day == data2.day &&
        data1.month == data2.month &&
        data1.year == data2.year) {
      return true;
    }

    return false;
  }

    static int paraInteiro(valor) {
    double multiplier = .5;
    return (multiplier * valor).round();
  }

  static String getPrimeiroNome(String nome) {
    if (nome.isEmpty) {
      return "";
    }
    String nome1 = nome;
    var i = nome.indexOf(' ');
    if (i > -1) {
      nome1 = nome.substring(0, i);
    }
    return nome1;
  }  

  static String exibirTot(int tot) {
    String info = "";

    if (tot == 0) {
      info = "Sem itens";
    } else if (tot == 1) {
      info = "Um item";
    } else {
      info = tot.toString() + " iten(s)";
    }
    return info;
  }

  
}
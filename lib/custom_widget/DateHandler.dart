import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
class DateHandler{
   myDate(int timeStanp){
     String local = "fr-FR";
    initializeDateFormatting(local,null);
    DateTime now = DateTime.now();
    DateFormat format;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timeStanp);
    if(now.difference(date).inDays>0){
      format = DateFormat.yMMMd(local);
    }else{
      format = DateFormat.Hm(local);
    }
    return format.format(date).toString();
  }
}
import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';

class DateUtils {
  DateTime getDateTime(String data) {
    if (data != null && UtilData.validarData(data)) {
      final list = data.split("/");
      if (list.length != 3) return null;
      return DateFormat.yMd('pt_BR').parse(data);
    }
    return null;
  }

  String getDataBrFromDate(DateTime date) {
    if (date == null) return null;
    final f = new DateFormat('dd/MM/yyyy');
    return f.format(date);
  }
}

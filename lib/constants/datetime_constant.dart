import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toTime() {
    return DateFormat('HH:mm').format(this);
  }

  String toIndonesianCommon() {
    return DateFormat('dd MMMM yyyy', 'id_ID').format(this);
  }

  String toAbbreviationCommon() {
    return DateFormat('dd MMM yyyy', 'id_ID').format(this);
  }

  String toSlashSeparated() {
    return DateFormat('d/MM/yyyy', 'id_ID').format(this);
  }

  String toApiFormatter() {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(this);
  }
}

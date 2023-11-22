import 'package:intl/intl.dart';

extension StringExtension on String {
  DateTime fromMiliSecond() {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(this));
  }

  DateTime fromIndonesianCommonToDateTime() {
    return DateFormat('dd MMMM yyyy', 'id_ID').parse(this);
  }

  DateTime fromSlashSeparatedToDateTime() {
    return DateFormat('d/MM/yyyy', 'id_ID').parse(this);
  }

  DateTime fromApiFormat() {
    return DateFormat(
      'yyyy-MM-ddTHH:mm:ss.SSS',
    ).parse(this, true);
  }

  DateTime fromApiFormat3() {
    return DateFormat(
      'yyyy-MM-dd',
    ).parse(this, true);
  }

  DateTime fromApiFormat2() {
    return DateFormat(
      "yyyy-MM-ddTHH:mm:ssZ",
    ).parse(this, true);
  }
}

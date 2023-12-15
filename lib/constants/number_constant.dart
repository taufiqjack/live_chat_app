import 'package:intl/intl.dart';

extension NumberExtention on int {
  String phoneFormat() {
    return NumberFormat("#,###0", "id_ID").format(this);
  }
}

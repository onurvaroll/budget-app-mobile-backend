import 'package:intl/intl.dart';

class AmountHelper {
  static final amountFormatter = NumberFormat.currency(
    locale: 'tr_TR',
    symbol: '₺',
    decimalDigits: 2,
  );
}

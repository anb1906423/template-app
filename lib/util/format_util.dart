import 'package:intl/intl.dart';

class FormatUtils {
  static String formatPrice(String price) {
    final numberFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '');
    try {
      final formattedPrice = numberFormat.format(double.parse(price));
      return formattedPrice;
    } catch (e) {
      return price;
    }
  }
}


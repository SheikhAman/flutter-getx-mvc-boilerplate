import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  // Date Formatters
  static String formatDate(DateTime? date, {String pattern = 'dd MMM yyyy'}) {
    if (date == null) return '';
    return DateFormat(pattern).format(date);
  }

  static String formatDateTime(DateTime? dateTime,
      {String pattern = 'dd MMM yyyy, hh:mm a'}) {
    if (dateTime == null) return '';
    return DateFormat(pattern).format(dateTime);
  }

  static String timeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';
    final difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '${months}mo ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '${years}y ago';
    }
  }

  // Currency Formatters
  static String formatCurrency(num? amount,
      {String symbol = '\$', int decimalDigits = 2}) {
    if (amount == null) return '$symbol 0.00';
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  static String formatBDT(num? amount) {
    return formatCurrency(amount, symbol: '৳ ', decimalDigits: 0);
  }

  static String formatUSD(num? amount) {
    return formatCurrency(amount, symbol: '\$ ', decimalDigits: 2);
  }

  // Text & Number Formatters
  static String capitalize(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  static String maskPhone(String? phone) {
    if (phone == null || phone.length < 6) return phone ?? '';
    final visibleStart = phone.substring(0, 3);
    final visibleEnd = phone.substring(phone.length - 2);
    final masked = '*' * (phone.length - 5);
    return '$visibleStart$masked$visibleEnd';
  }

  static String compactNumber(num? number) {
    if (number == null) return '0';
    return NumberFormat.compact().format(number);
  }
}

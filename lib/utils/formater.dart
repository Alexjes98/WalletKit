String toMoneyFormat(double value) {
  var parts = value.toStringAsFixed(2).split('.');
  var integerPart = parts[0];
  var decimalPart = parts[1];
  var result = '';
  var count = 0;
  for (var i = integerPart.length - 1; i >= 0; i--) {
    count++;
    result = integerPart[i] + result;
    if (count == 3 && i > 0) {
      result = ',$result';
      count = 0;
    }
  }
  return '$result.$decimalPart';
}

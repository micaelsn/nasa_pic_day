String dateFormatter(String date) {
  var newDateArray = date.split('-');
  return '${newDateArray[2]}/${newDateArray[1]}/${newDateArray[0]}';
}

String dateFormatterDateTime(DateTime date) {
  return '${date.year}-${date.month > 9 ? '' : 0}${date.month}-${date.day > 9 ? '' : 0}${date.day}';
}

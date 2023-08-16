String generateRandomIdByDate() {
  var now = DateTime.now();
  var id = now.year.toString() +
      now.month.toString() +
      now.day.toString() +
      now.hour.toString() +
      now.minute.toString() +
      now.second.toString();
  return id;
}

enum TypeEventDaily {
  notRepeat,
  daily,
  weekly,
}

extension TypeEventDailyOnString on String {
  TypeEventDaily typeEventDailyFromMap() {
    switch (toUpperCase()) {
      case 'NOTREPEAT':
        return TypeEventDaily.notRepeat;
      case 'DAILY':
        return TypeEventDaily.daily;
      case 'WEEKLY':
        return TypeEventDaily.weekly;
      default:
        return TypeEventDaily.daily;
    }
  }
}

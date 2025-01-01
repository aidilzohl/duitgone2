import 'dart:math';

class Money {
  final double amount;
  final String category;
  final DateTime date;

  const Money({
    required this.amount,
    required this.category,
    required this.date,
  });

  static List<Money> generateMockData({double total = 10}) {
    final random = Random();

    const categories = [
      "Breakfast",
      "Lunch",
      "Dinner",
      "Grocery",
      "Hygiene",
      "Subscription",
      "Others"
    ];

    const min = -25.0;
    const max = 25.0;

    final moneys = <Money>[];

    for (var i = 0; i < total; i++) {
      final category = categories[random.nextInt(categories.length)];
      final amount = random.nextDouble() * (min.abs() + max.abs()) + min;
      final now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        random.nextInt(23),
        random.nextInt(59),
      );

      final money = Money(amount: amount, category: category, date: date);

      moneys.add(money);
    }
    return moneys;
  }
}
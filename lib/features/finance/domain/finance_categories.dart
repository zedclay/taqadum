import '../../../core/database/app_database.dart';

/// Built-in finance categories, stored by stable id. Anything else in
/// `finance_transactions.category` is a user-written custom category.
abstract final class FinanceCategories {
  static const food = 'food';
  static const transport = 'transport';
  static const home = 'home';
  static const bills = 'bills';
  static const family = 'family';
  static const health = 'health';
  static const education = 'education';
  static const business = 'business';
  static const shopping = 'shopping';
  static const salary = 'salary';
  static const clientPayment = 'clientPayment';
  static const freelance = 'freelance';
  static const gift = 'gift';
  static const emergency = 'emergency';
  static const savingsGoal = 'savingsGoal';
  static const investment = 'investment';

  static const expense = [
    food,
    transport,
    home,
    bills,
    family,
    health,
    education,
    business,
    shopping,
  ];
  static const income = [salary, clientPayment, business, freelance, gift];
  static const saving = [emergency, savingsGoal, investment];

  static final Set<String> all = {...expense, ...income, ...saving};

  static List<String> forType(TransactionType type) => switch (type) {
    TransactionType.expense => expense,
    TransactionType.income => income,
    TransactionType.saving => saving,
  };

  static bool isBuiltIn(String category) => all.contains(category);
}

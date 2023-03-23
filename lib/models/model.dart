class PaymentItem {
  final String name;
  final String description;
  bool isPaid;
  String chapter;

  PaymentItem(
      {required this.name,
      required this.description,
      required this.isPaid,
      required this.chapter});
}

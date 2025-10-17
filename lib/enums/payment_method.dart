enum PaymentMethod {
  cash("Cash", "Efectivo"),
  yape("Yape", "Yape"),
  card("Card", "Tarjeta Credito");

  const PaymentMethod(this.value, this.displayName);
  final String value;
  final String displayName;
}

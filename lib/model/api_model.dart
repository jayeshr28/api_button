class LED1 {
  final success;
  final LED_1;

  const LED1({required this.success, required this.LED_1});

  factory LED1.fromJson(Map<String, dynamic> json) {
    return LED1(
      success: json['success'],
      LED_1: json['LED_1'],
    );
  }
}

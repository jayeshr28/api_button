class LED1 {
  final success;
  final message;

  const LED1({required this.success, required this.message});

  factory LED1.fromJson(Map<String, dynamic> json) {
    return LED1(
      success: json['success'],
      message: json['message'],
    );
  }
}

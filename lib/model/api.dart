class TriggerApiButton {
  Future<String> getApi(String status) async {
    return 'https://iotmachlab.000webhostapp.com/api/LED_1/update.php?id=1&status=$status';
  }
}

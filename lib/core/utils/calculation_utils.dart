class CalculationUtils {
  static String calculateBTCEquivalent(
    double usdAmount, {
    double btcPrice = 50000.0,
  }) {
    return (usdAmount / btcPrice).toStringAsFixed(0);
  }

  static double calculateTotalAssets(
    double spotVolume, {
    double multiplier = 6.0,
  }) {
    return spotVolume * multiplier;
  }
}

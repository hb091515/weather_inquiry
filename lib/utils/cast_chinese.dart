class CastChinese {
  String getChineseName(String englishName) {
    switch (englishName) {
      case "Wx":
        return "天氣狀況";
      case "PoP":
        return "降雨機率";
      case "CI":
        return "舒適度";
      case "MinT":
        return "最低溫度";
      case "MaxT":
        return "最高溫度";
      default:
        return "";
    }
  }

  String getUnit(String unit) {
    switch (unit) {
      case "百分比":
        return "%";
      case "C":
        return "°C";
      default:
        return "";
    }
  }
}

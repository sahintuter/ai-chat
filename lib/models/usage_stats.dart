class UsageStats {
  late final int dailyTokenLimit;
  late final int usedTokens;
  late final DateTime lastResetDate;

  bool get canSendMessage => usedTokens < dailyTokenLimit;
}

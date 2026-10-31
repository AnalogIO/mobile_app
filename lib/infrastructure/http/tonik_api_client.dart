import 'package:analog_api/analog_api.dart';

/// Groups the generated Tonik API clients behind one dependency.
class TonikApiClient {
  new({required this.server})
    : account = AccountApi(server),
      leaderboard = LeaderboardApi(server),
      statistics = StatisticsApi(server),
      tickets = TicketsApi(server),
      products = ProductsApi(server),
      menuItems = MenuItemsApi(server),
      programmes = ProgrammesApi(server),
      purchases = PurchasesApi(server),
      receipts = ReceiptApi(server),
      vouchers = VouchersApi(server);

  final Server server;
  final AccountApi account;
  final LeaderboardApi leaderboard;
  final StatisticsApi statistics;
  final TicketsApi tickets;
  final ProductsApi products;
  final MenuItemsApi menuItems;
  final ProgrammesApi programmes;
  final PurchasesApi purchases;
  final ReceiptApi receipts;
  final VouchersApi vouchers;

  void close() => server.close();
}

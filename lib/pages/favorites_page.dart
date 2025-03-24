import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> dummyFavorites = [
    {
      "title": "Spotify %50 Cashback",
      "wallet": "Papara",
      "rate": 50,
    },
    {
      "title": "Trendyol 15% İndirim",
      "wallet": "SanalKart",
      "rate": 15,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorilerim")),
      body: dummyFavorites.isEmpty
          ? Center(child: Text("Henüz favori kampanyanız yok."))
          : ListView.builder(
              itemCount: dummyFavorites.length,
              itemBuilder: (context, index) {
                final campaign = dummyFavorites[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    title: Text(campaign["title"]),
                    subtitle: Text("Cüzdan: ${campaign["wallet"]}"),
                    trailing: Text("%${campaign["rate"]}"),
                  ),
                );
              },
            ),
    );
  }
}
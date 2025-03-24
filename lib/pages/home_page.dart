import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> campaigns = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCampaigns();
  }

  Future<void> fetchCampaigns() async {
    try {
      List<Map<String, dynamic>> data = await ApiService.fetchCampaigns();
      setState(() {
        campaigns = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Kampanyalar yüklenirken hata oluştu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tüm Kampanyalar")),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Yükleme göstergesi
          : campaigns.isEmpty
              ? Center(child: Text("Kampanya bulunamadı."))
              : ListView.builder(
                  itemCount: campaigns.length,
                  itemBuilder: (context, index) {
                    final campaign = campaigns[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: ListTile(
                        title: Text(campaign["title"]),
                        subtitle: Text("Cüzdan: ${campaign["wallet_name"]}"),
                        trailing: Text("%${campaign["cashback_rate"]}"),
                      ),
                    );
                  },
                ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TransactionDetails {
  final String avatar;
  final String name;
  final String date;
  final String amount;

  TransactionDetails({required this.avatar, required this.name, required this.date, required this.amount});

  factory TransactionDetails.fromJson(Map<String, dynamic> json) {
    return TransactionDetails(
        avatar: json['avatar'],
        name: json['name'],
        date: json['date'],
        amount: json['amount']);
  }
}

class transfer extends StatefulWidget {
  const transfer({super.key});

  @override
  State<transfer> createState() => _transferState();
}

class _transferState extends State<transfer> {
  Future<List<TransactionDetails>> fetchTransaction() async {
    final response = await http.get(Uri.parse("https://brotherlike-navies.000webhostapp.com/people/people.php" ));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      print(result);
      return result.map((e) => TransactionDetails.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15),
                        width: 319,
                        height: 100,
                        color: Colors.green,
                        alignment: Alignment.center,
                        child: const Text(
                          '\$5200.00',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(15),
                        width: 319,
                        height: 100,
                        color: Colors.green,
                        alignment: Alignment.center,
                        child: const Text(
                          '\$1200.00',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    "Recent Transactions",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ),
                Center(
                  child: FutureBuilder<List<TransactionDetails>>(
                    future: fetchTransaction(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                child: Image.network(
                                    snapshot.data![index].avatar.toString()),
                              ),
                              title: Text(snapshot.data![index].name.toString()),
                              trailing:
                              Text(snapshot.data![index].amount.toString()),
                              subtitle: Text(
                                  snapshot.data![index].date.toString()),
                            );
                          },
                        );
                      }
                      else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
              ],
            ),

          ),
        )
    );
  }
}



import 'package:david_c_mini/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final DateTime selectedDate;
  const HomePage({super.key, required this.selectedDate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // dashboard total income and expenses
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Icon(Icons.download, color: Colors.green),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Income",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 12)),
                            SizedBox(height: 8),
                            Text("Rp. 3.800.000",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 14))
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: Icon(Icons.upload, color: Colors.red),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Expense",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 12)),
                            SizedBox(height: 8),
                            Text("Rp. 1.600.000",
                                style: GoogleFonts.montserrat(
                                    color: Colors.white, fontSize: 14))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            // text transactions
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Transactions",
                style: GoogleFonts.montserrat(
                  fontSize: 16, fontWeight: FontWeight.bold)
              ),
            ),
            StreamBuilder(

              builder: (context, snapshot) {
                return const Center();
              }),

            // list transactions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 10,
                child: ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 10),
                      Icon(Icons.edit),
                    ],
                  ),
                  title: Text("Rp. 2.000.000"),
                  subtitle: Text("Gaji Bulanan"),
                  leading: Container(
                    child: Icon(Icons.download, color: Colors.green),
                    decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 10,
                child: ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width: 10),
                      Icon(Icons.edit),
                    ],
                  ),
                  title: Text("Rp. 20.000"),
                  subtitle: Text("Makan Siang"),
                  leading: Container(
                    child: Icon(Icons.upload, color: Colors.red),
                    decoration: BoxDecoration(
                      color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

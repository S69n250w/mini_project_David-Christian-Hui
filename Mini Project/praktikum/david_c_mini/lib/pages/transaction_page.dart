import 'package:david_c_mini/models/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final AppDatabase database = AppDatabase();
  bool isExpense = true;
  late int type;
  List<String> list = ['Makan dan Jajan', 'Transportasi', 'Nonton Anime'];
  late String dropDownValue = list.first;
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController detailController = TextEditingController();
  Category? selectedCategory;

  Future insert(int amount, int categoryId, DateTime date, String nameDetail) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.transactions).insertReturning(
      TransactionsCompanion.insert(
        name: nameDetail,
        category_id: categoryId,
        transaction_date: date,
        amount: amount,
        type: type,
        createdAt: now,
        updatedAt: now));
    print('APA INI: ' + row.toString());
    // there is an insert into the database
  }

  Future<List<Category>> getAllCategory(int type) async {
    return await database.getAllCategoryRepo(type);
  }

  @override
  void initState() {
    // TODO: implement initState
    type = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transaction"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Switch(
                  value: isExpense,
                  onChanged: (bool value) {
                    setState(() {
                      isExpense = value;
                      type = (isExpense) ? 2 : 1;
                      selectedCategory = null;
                    });
                  },
                  inactiveTrackColor: Colors.green[200],
                  inactiveThumbColor: Colors.green,
                  activeColor: Colors.red,
                ),
                Text(
                  isExpense ? "Expense" : "Income",
                  style: GoogleFonts.montserrat(fontSize: 14),
                ),
              ],
            ),
            SizedBox(
              height: 10
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Amount"),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Category",
                style: GoogleFonts.montserrat(fontSize: 16)
              ),
            ),
            FutureBuilder<List<Category>>(
              future: getAllCategory(type),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length > 0) {
                      selectedCategory = snapshot.data!.first;
                      print(snapshot.toString());
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: DropdownButton<Category>(
                          value: (selectedCategory == null)
                              ? snapshot.data!.first
                              : selectedCategory,
                          isExpanded: true,
                          icon: Icon(Icons.arrow_downward),
                          items: snapshot.data!.map((Category item) {
                            return DropdownMenuItem<Category>(
                              value: item,
                              child: Text(item.name)
                            );
                          }).toList(),
                            onChanged: (Category? value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            }
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("Empty data"),
                    );
                    }
                  } else {
                    return Center(
                      child: Text("Has no data"),
                    );
                  }
                }
              }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButton<String>(
                value: dropDownValue,
                isExpanded: true,
                icon: Icon(Icons.arrow_downward),
                  items: list.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? value) {}
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                readOnly: true,
                controller: dateController,
                decoration: InputDecoration(labelText: "Enter Date"),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2099)
                  );
            
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            
                    dateController.text = formattedDate;
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: detailController,
                decoration: InputDecoration(
                    border: UnderlineInputBorder(), labelText: "Detail"),
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  insert(
                    int.parse(amountController.text),
                    selectedCategory!.id,
                    DateTime.parse(dateController.text),
                    detailController.text);
                  Navigator.pop(context, true);
                },
                child: Text("Save"))
            ),
          ],
        )),
      ),
    );
  }
}

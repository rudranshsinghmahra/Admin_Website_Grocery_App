import 'package:admin_app_grocery/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorDataTable extends StatelessWidget {
  const VendorDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    return StreamBuilder<QuerySnapshot>(
      stream:
          services.vendors.orderBy('shopName', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something Went Wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            showBottomBorder: true,
            dataRowHeight: 60,
            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
            columns: const [
              DataColumn(
                label: Text("Active/Inactive"),
              ),
              DataColumn(
                label: Text("Top Picked"),
              ),
              DataColumn(
                label: Text("Shop Name"),
              ),
              DataColumn(
                label: Text("Rating"),
              ),
              DataColumn(
                label: Text("Total Sales"),
              ),
              DataColumn(
                label: Text("Mobile"),
              ),
              DataColumn(
                label: Text("Email"),
              ),
              DataColumn(
                label: Text("View Details"),
              ),
            ],
            rows: vendorsDetailsRow(snapshot.data),
          ),
        );
      },
    );
  }

  List<DataRow> vendorsDetailsRow(QuerySnapshot? snapshot) {
    List<DataRow> newList =
        snapshot!.docs.map((DocumentSnapshot documentSnapshot) {
      return DataRow(cells: [
        DataCell(IconButton(
          onPressed: () {},
          icon: documentSnapshot['accVerified']
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
        )),
        DataCell(IconButton(
          onPressed: () {},
          icon: documentSnapshot['isTopPicked']
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(null),
        )),
        DataCell(Text(documentSnapshot['shopName'])),
        DataCell(Row(
          children: const [Icon(Icons.star), Text("3.5")],
        ),),
        const DataCell(Text("20,000")),
        DataCell(Text(documentSnapshot['mobile'])),
        DataCell(Text(documentSnapshot['email'])),
        DataCell(IconButton(
          icon: const Icon(Icons.remove_red_eye_outlined),
          onPressed: () {},
        ))
      ]);
    }).toList();
    return newList;
  }
}

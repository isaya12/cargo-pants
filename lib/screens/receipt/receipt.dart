import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Receipt Preview"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Generate PDF and preview it
            final pdf = await _generatePdf();
            await Printing.layoutPdf(
              onLayout: (PdfPageFormat format) async => pdf.save(),
            );
          },
          child: Text("Generate Receipt"),
        ),
      ),
    );
  }

  Future<pw.Document> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll57,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("TRUST FIRST",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 8),
              pw.Text("Cargo Receipt", style: pw.TextStyle(fontSize: 12)),
              pw.Text("Booking ID: 84379321"),
              pw.Text("Brand Name: Trust Transportation Services"),
              pw.SizedBox(height: 10),
              pw.Text("Journey Route: Dar es Salaam - Dodoma"),
              pw.Text("Shipping Date: 2024-11-06"),
              pw.Text("Arrival Date: 2024-11-06"),
              pw.SizedBox(height: 10),
              pw.Text("Paid Amount: 50000 TSH"),
              pw.SizedBox(height: 10),
              pw.Text("Sender Details"),
              pw.Text("Name: Richard Thomas"),
              pw.Text("Phone: 0768448525"),
              pw.Text("Receiver Name: Sambokile Kindecki"),
              pw.Text("Receiver Phone: 0613492580"),
              pw.SizedBox(height: 10),
              pw.Text("Package Information"),
              pw.Text("Description: White Maize Diesel"),
              pw.Text("Weight: 200kg"),
              pw.Text("Size: Large"),
              pw.Text("Type: Undefined"),
              pw.SizedBox(height: 10),
              pw.Text("Agent Phone: 0768448525"),
              pw.Text("Bus Company: Usiri Transportation Services"),
              pw.Text("Customer Service: 0768448525"),
              pw.Text("Dar es Salaam: 0752219251 / 0746396094"),
              pw.Text("Dodoma: 0752219251 / 0746396094"),
              pw.SizedBox(height: 10),
              pw.BarcodeWidget(
                data: "84379321",
                width: 100,
                height: 50,
                barcode: pw.Barcode.code128(),
              ),
              pw.Text("Asante kwa kuchagua TRUST FIRST"),
            ],
          );
        },
      ),
    );

    return pdf;
  }
}

class InvoiceListDataModel {
  InvoiceListDataModel({
    required this.headings,
    required this.invlist,
    required this.totalRecords,
    required this.totalPages,
    required this.pageNum,
    required this.perPage,
  });

  final List<String> headings;
  final List<List<String?>> invlist;
  final int? totalRecords;
  final int? totalPages;
  final String? pageNum;
  final int? perPage;

  factory InvoiceListDataModel.fromJson(Map<String, dynamic> json) {
    return InvoiceListDataModel(
      headings: json["headings"] == null
          ? []
          : List<String>.from(json["headings"]!.map((x) => x)),
      invlist: json["invlist"] == null || json["invlist"] is! List
          ? []
          : List<List<String>>.from(
              json["invlist"]!.map(
                (x) => x == null
                    ? []
                    : List<String>.from(
                        x!.map(
                          (x) => x?.toString() ?? '-',
                        ),
                      ),
              ),
            ),
      totalRecords: json["total_records"],
      totalPages: json["total_pages"],
      pageNum: json["page_num"],
      perPage: json["per_page"],
    );
  }
}

class Invlist {
  Invlist({
    required this.slno,
    required this.month,
    required this.status,
    required this.revenue,
    required this.anpshare,
    required this.monthlyincentive,
    required this.netshare,
    required this.invoicevalue,
    required this.invoicedate,
    required this.netpayable,
    required this.invoiceno,
  });

  final String? slno;
  final String? month;
  final String? status;
  final String? revenue;
  final String? anpshare;
  final String? monthlyincentive;
  final String? netshare;
  final String? invoicevalue;
  final String? invoicedate;
  final String? netpayable;
  final String? invoiceno;

  factory Invlist.fromJson(Map<String, dynamic> json) {
    return Invlist(
      slno: json["slno"]?.toString(),
      month: json["month"]?.toString(),
      status: json["status"]?.toString(),
      revenue: json["revenue"]?.toString(),
      anpshare: json["anpshare"]?.toString(),
      monthlyincentive: json["monthlyincentive"]?.toString(),
      netshare: json["netshare"]?.toString(),
      invoicevalue: json["invoicevalue"]?.toString(),
      invoicedate: json["invoicedate"]?.toString(),
      netpayable: json["netpayable"]?.toString(),
      invoiceno: json["invoiceno"]?.toString(),
    );
  }
}

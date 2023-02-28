class query1DataModel {
  
  var provincename;
  var provinceid;

  query1DataModel({
    required this.provincename,
    required this.provinceid
    });

  factory query1DataModel.fromJSON(Map<String, dynamic> datarow)

  {
    return query1DataModel(
      provincename: datarow['province_name'],
      provinceid: datarow['province_id'],
      );
  }
}

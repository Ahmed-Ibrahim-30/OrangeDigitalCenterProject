class SectionModel{
  List<SectionDetails>data=[];
  SectionModel.fromJson(List<dynamic>json){
    for (var element in json) {
      data.add(SectionDetails.fromJson(element));
    }
  }
}

class SectionDetails{
  int ?id;
  String ?sectionSubject;
  String ?sectionDate;
  String ?sectionStartTime;
  String ?sectionEndTime;
  SectionDetails.fromJson(Map<String,dynamic>json){
    id=json['id'];
    sectionSubject=json['sectionSubject'];
    sectionDate=json['sectionDate'];
    sectionStartTime=json['sectionStartTime'];
    sectionEndTime=json['sectionEndTime'];
    List<String>arr=sectionStartTime!.split(':');
    List<String>arr2=sectionEndTime!.split(':');
    sectionStartTime="${arr.elementAt(0)}:${arr.elementAt(1)}";
    sectionEndTime="${arr2.elementAt(0)}:${arr2.elementAt(1)}";
  }

}
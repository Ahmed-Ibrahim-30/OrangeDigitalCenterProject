class LectureModel{
  List<LectureDetails>data=[];
  LectureModel.fromJson(List<dynamic>json){
    for (var element in json) {
      data.add(LectureDetails.fromJson(element));
    }
  }
}

class LectureDetails{
  int ?id;
  String ?lectureSubject;
  String ?lectureDate;
  String ?lectureStartTime;
  String ?lectureEndTime;
  LectureDetails.fromJson(Map<String,dynamic>json){
    id=json['id'];
    lectureSubject=json['lectureSubject'];
    lectureDate=json['lectureDate'];
    lectureStartTime=json['lectureStartTime'];
    lectureEndTime=json['lectureEndTime'];
    List<String>arr=lectureStartTime!.split(':');
    List<String>arr2=lectureEndTime!.split(':');
    lectureStartTime="${arr.elementAt(0)}:${arr.elementAt(1)}";
    lectureEndTime="${arr2.elementAt(0)}:${arr2.elementAt(1)}";
  }

}
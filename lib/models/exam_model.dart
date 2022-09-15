class ExamModel{
  List<ExamDetails>finalExams=[];
  List<ExamDetails>midtermExams=[];
  ExamModel.fromJson(List<dynamic>json){
    for (var element in json) {
      if(element['final']){
        midtermExams.add(ExamDetails.fromJson(element));
      }
      else{
        finalExams.add(ExamDetails.fromJson(element));
      }
    }
  }
}

class ExamDetails{
  int ?id;
  String ?examSubject;
  String ?examDate;
  String ?examStartTime;
  String ?examEndTime;
  bool ?isMidterm;
  ExamDetails.fromJson(Map<String,dynamic>json){
    id=json['id'];
    examSubject=json['examSubject'];
    examDate=json['examDate'];
    examStartTime=json['examStartTime'];
    examEndTime=json['examEndTime'];
    isMidterm=json['isMidterm'];
    List<String>arr=examStartTime!.split(':');
    List<String>arr2=examEndTime!.split(':');
    examStartTime="${arr.elementAt(0)}:${arr.elementAt(1)}";
    examEndTime="${arr2.elementAt(0)}:${arr2.elementAt(1)}";
  }

}
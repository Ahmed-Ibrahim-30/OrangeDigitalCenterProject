class NoteModel{
  int ?id;
  String ?title;
  String ?description;
  String ?date;
  NoteModel({
   required this.title,
   required this.description,
   required this.date,
   required this.id,
});
}
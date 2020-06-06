class ToDoItem{


  String dataText;
  bool isDone = false;
  int currentTimeStamp;



  ToDoItem({this.dataText, this.isDone = false, this.currentTimeStamp}){
    currentTimeStamp = currentTimeStamp == null ? DateTime.now().toUtc().millisecondsSinceEpoch : currentTimeStamp;
  }

  void toggleStatus(){

    isDone = !isDone;

  }

}
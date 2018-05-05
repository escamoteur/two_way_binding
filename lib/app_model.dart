import 'package:flutter/foundation.dart';



class FormEntry {
  String title;
  String content;

  FormEntry(this.title,this.content);
}

class AppModel extends ChangeNotifier{
    List<FormEntry> formEntries = new List<FormEntry>();


    String singleFieldValue = "Just a single Field";

    AppModel()
    {
      formEntries.addAll(
        [
          FormEntry("Name:","Burkhart"),
          FormEntry("First Name:","Thomas"),
          FormEntry("email:","tom@mydomain.de"),
          FormEntry("Country:","Wakanda"),
        ]);
        printContent();
    }


    updateSingleValueField(String value ) => singleFieldValue = value; 

    updateFormEntry(int index, String value) => formEntries[index].content = value;

    changeAppModel()
    {
      formEntries.clear();
      formEntries.addAll(
        [
          FormEntry("Name:","New Name"),
          FormEntry("First Name:","New First Name"),
          FormEntry("email:","New email"),
          FormEntry("Country:","New Country"),
        ]);

      notifyListeners();
    }


    void printContent()
    {
        print("Single TextField: $singleFieldValue");
        print("\n");

        formEntries.forEach((entry)=> print("Field: ${entry.title} - Content: ${entry.content}"));
        print(" ");
    }
}
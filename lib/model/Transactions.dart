class Transactions{
  String name;
  String number;
  String nomo;
  final DateTime date;
  String selectedValue;
  final imageFile;
  String gender;

  Transactions(
    { 
      required this.name,
      required this.number,
      required this.selectedValue,

      required this.nomo,
      required this.date,
      required this.imageFile,
      required this.gender    
     
    }
  );
}
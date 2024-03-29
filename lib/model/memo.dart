import 'package:cloud_firestore/cloud_firestore.dart';

class Free {
  String id;
  Timestamp createdDate;
  Timestamp? updateDate;
  String freeTitle;
  String freeContent; 
  String userid; 

  Free({
    // common
    required this.id,
    required this.createdDate,
    this.updateDate,
    required this.freeTitle,
    required this.freeContent,
    required this.userid,
  });
}

class Value {
  String id;
  Timestamp createdDate;
  Timestamp? updateDate;
  String valueContent;
  String valueReason;
  String valueSubject;
  String userid; 

  Value({    
    required this.id,
    required this.createdDate,
    this.updateDate,
    required this.valueContent,
    required this.valueReason,
    required this.valueSubject,
    required this.userid,
    
  });
}

class Word {
  String id;
  Timestamp createdDate;
  Timestamp? updateDate;
  String word;
  String wordReason;
  String wordType;
  String userid; 

  Word({    
    required this.id,
    required this.createdDate,
    this.updateDate,
    required this.word,
    required this.wordReason,
    required this.wordType,
    required this.userid,
    
  });
}

class Feel {
  String id;
  Timestamp createdDate;
  Timestamp? updateDate;
  String feelType;
  String feelReason;
  String feelAdvice;
  String userid; 

  Feel({    
    required this.id,
    required this.createdDate,
    this.updateDate,
    required this.feelType,
    required this.feelReason,
    required this.feelAdvice,
    required this.userid,
    
  });
}
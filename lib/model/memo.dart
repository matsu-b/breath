import 'package:cloud_firestore/cloud_firestore.dart';

class Free {
  String id;
  Timestamp createdDate;
  Timestamp? updateDate;
  String freeTitle;
  String freeContent; 

  Free({
    // common
    required this.id,
    required this.createdDate,
    this.updateDate,
    required this.freeTitle,
    required this.freeContent,
  });
}

class Memo {
  // common
  String id;
  Timestamp createdDate;
  Timestamp? updateDate;
  String detail;
  String title;

  Memo({
    // common
    required this.id,
    required this.createdDate,
    this.updateDate,
    required this.detail,
    required this.title,
    
  });
}

class Value {
  String id;
  Timestamp createdDate;
  Timestamp? updateDate;
  String valueContent;
  String valueReason;
  String valueSubject;

  Value({    
    required this.id,
    required this.createdDate,
    this.updateDate,
    required this.valueContent,
    required this.valueReason,
    required this.valueSubject,
    
  });
}

class Word {
  String id;
  Timestamp createdDate;
  Timestamp? updateDate;
  String word;
  String wordReason;
  String wordType;

  Word({    
    required this.id,
    required this.createdDate,
    this.updateDate,
    required this.word,
    required this.wordReason,
    required this.wordType,
    
  });
}

class Feel {
  String id;
  Timestamp createdDate;
  Timestamp? updateDate;
  String feelType;
  String feelReason;
  String feelAdvice;

  Feel({    
    required this.id,
    required this.createdDate,
    this.updateDate,
    required this.feelType,
    required this.feelReason,
    required this.feelAdvice,
    
  });
}
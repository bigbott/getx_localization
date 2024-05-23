
import 'dart:convert';

Map<String, String> jsonToMap(String jsonString){
  //Map<String, dynamic> map = json.decode(jsonString);
  //Map<String, String> result = {};
  //for ()
  return Map.castFrom(json.decode(jsonString));
}
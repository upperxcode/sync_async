import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() async {
  final todo = await fetch();
  print(todo.title);
  print(todo.toJson());
  print(strToInt('2'));
  print(strToDouble('2.003d'));
}

//testeSequencial();

Future<Todo> fetch() async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');
  var response = await http.get(url);
  var json = jsonDecode(response.body);
  var todo = Todo.fromJson(json);
  return todo;
}

class Todo {
  final String title;
  final int id;
  final int userId;
  final bool completed;

  Todo({
    required this.title,
    required this.id,
    required this.userId,
    required this.completed,
  });

  factory Todo.fromJson(Map json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  Map toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'userId': userId,
    };
  }
}

int strToInt(String v) {
  int value;
  try {
    value = int.parse(v);
  } catch (e) {
    throw Exception('Erro! O valor ($v) não é um número inteiro válido!');
  }
  return value;
}

double strToDouble(String v) {
  double value;
  try {
    value = double.parse(v.replaceAll(',', '.'));
  } catch (e) {
    throw Exception('Erro! O valor ($v) não é um número double válido!');
  }

  return value;
}

void testeSequencial() {
  var future = Future.delayed(Duration(seconds: 2));
  future.then((v) => print('1'));
  print5();
  print('2');
  print('3');
  print('4');
}

Future<void> print5() async {
  await Future.delayed(Duration(seconds: 2));
  print('5');
}


/*
import 'package:sync_async/sync_async.dart' as sync_async;

void main(List<String> arguments) {
  print('Hello world: ${sync_async.calculate()}!');
}*/

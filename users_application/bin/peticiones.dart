import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

void main() async {
  try {
    // Llamar a la función fetchUsers 
    List<User> users = await fetchUsers();

    users.forEach((user) {
      print('ID: ${user.id}');
      print('Name: ${user.name}');
      print('Username: ${user.username}');
      print('Email: ${user.email}');
      print('Address: ${user.address.street}, ${user.address.city}');
      print('Phone: ${user.phone}');
      print('Website: ${user.website}');
      print('Company: ${user.company.name}');
      print('------------');
    });

    
    filtroNombre(users);
    contarUsuarios(users);
  } catch (e) {
    print('Ocurrió un error: $e');
  }
}


Future<List<User>> fetchUsers() async {

  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

  // Realizar la petición GET
  final response = await http.get(url);


  if (response.statusCode == 200) {   // 200 corresponde si es exitosa
    
    List<dynamic> jsonData = json.decode(response.body);

    // Crear y retornar una lista de User
    return jsonData.map((json) => User.fromJson(json)).toList();
  } else {
    
    throw Exception('Error al obtener los datos: ${response.statusCode}');
  }
}


void filtroNombre(List<User> users) {
  print('Usuarios con nombre de más de 6 caracteres:');
  
  for (var user in users) {
    if (user.username.length > 6) {
      print('---------------------------');
      print('ID: ${user.id}');
      print('NOMBRE: ${user.username}');
      print('----------------------------');
    }
  }
}



void contarUsuarios(List<User> users) {
  int count = 0;

  for (var user in users) {
    if (user.email.endsWith('@biz')) {
      count++;
    }
  }

  print('Cantidad de usuarios cuyo correo electrónico pertenece al dominio @biz: $count');
}


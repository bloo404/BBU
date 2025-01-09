import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/constants/constants.dart';
import 'package:practical_exam/models/entity.dart';

class ApiService {
  static final ApiService instance = ApiService._init();
  static final Dio dio = Dio();
  Logger logger = Logger();

  ApiService._init();

  //Main Section            GET/pets
  Future<List<Entity>> getAll() async {
    logger.log(Level.info, "getAll() called");
    final response = await dio.get('${Constants.serverIpAdress}/pets');
    logger.log(Level.info, "getAll() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => Entity.fromJsonLess(e))
          .toList();
    } else {
      logger.log(Level.error, "getAll() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  //Main Section GET/pet/id
  Future<Entity> getPet(int id) async {
    logger.log(Level.info, "getPet() called");
    final response = await dio.get('${Constants.serverIpAdress}/pet/$id');
    logger.log(Level.info, "getPet() response: $response");

    if (response.statusCode == 200) {
      return Entity.fromJson(response.data);
    } else {
      logger.log(Level.error, "getPet() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  //Main Section            POST/pet
  Future<Entity> addEntity(Entity entity) async {
    logger.log(Level.info, "addEntity() called");
    final response = await dio.post('${Constants.serverIpAdress}/pet',
        data: entity.toJsonWithoutId());
    logger.log(Level.info, "addEntity() response: $response");

    if (response.statusCode == 200) {
      return Entity.fromJson(response.data);
    } else {
      logger.log(Level.error, "addEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  //Main Section           DELETE/pet
  Future<void> deleteEntity(int id) async {
    logger.log(Level.info, "deleteEntity() called");
    final response = await dio.delete('${Constants.serverIpAdress}/pet/$id');
    logger.log(Level.info, "deleteEntity() response: $response");

    if (response.statusCode != 200) {
      logger.log(
          Level.error, "deleteEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  //Search Section       GET/search - similar to /pets
  Future<List<Entity>> search() async {
    logger.log(Level.info, "search() called");
    final response = await dio.get('${Constants.serverIpAdress}/search');
    logger.log(Level.info, "search() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(Level.error, "search() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }
}

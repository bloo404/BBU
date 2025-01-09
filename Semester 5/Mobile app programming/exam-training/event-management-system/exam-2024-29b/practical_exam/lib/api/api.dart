import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/constants/constants.dart';
import 'package:practical_exam/models/entity.dart';

class ApiService {
  static final ApiService instance = ApiService._init();
  static final Dio dio = Dio();
  Logger logger = Logger();

  ApiService._init();

  // .../events
  Future<List<Entity>> getAll() async {
    logger.log(Level.info, "getAll() called");
    final response = await dio.get('${Constants.serverIpAdress}/events');
    logger.log(Level.info, "getAll() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(Level.error, "getAll() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // .../reserved
  Future<List<Entity>> getReserved() async {
    logger.log(Level.info, "getReserved() called");
    final response = await dio.get('${Constants.serverIpAdress}/reserved');
    logger.log(Level.info, "getReserved() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(Level.error, "getReserved() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // .../reserve/:id
  Future<void> reserveEntity(Entity entity) async {
    logger.log(Level.info, "reserveEntity() called");
    int? id = entity.id;
    final response =
        await dio.put('${Constants.serverIpAdress}/reserve/$id', data: entity);
    logger.log(Level.info, "reserveEntity() response: $response");

    if (response.statusCode != 200) {
      logger.log(
          Level.error, "reserveEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // .../attend/:id
  Future<void> attendEntity(Entity entity) async {
    logger.log(Level.info, "attendEntity() called");
    int? id = entity.id;
    final response =
        await dio.put('${Constants.serverIpAdress}/attend/$id', data: entity);
    logger.log(Level.info, "attendEntity() response: $response");

    if (response.statusCode != 200) {
      logger.log(
          Level.error, "attendEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // .../event
  Future<Entity> addEntity(Entity entity) async {
    logger.log(Level.info, "addEntity() called");
    final response = await dio.post('${Constants.serverIpAdress}/event',
        data: entity.toJsonWithoutId());
    logger.log(Level.info, "addEntity() response: $response");

    if (response.statusCode == 200) {
      return Entity.fromJson(response.data);
    } else {
      logger.log(Level.error, "addEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }
}

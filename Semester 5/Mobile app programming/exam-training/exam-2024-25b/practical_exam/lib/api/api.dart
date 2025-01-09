import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/constants/constants.dart';
import 'package:practical_exam/models/entity.dart';

class ApiService {
  static final ApiService instance = ApiService._init();
  static final Dio dio = Dio();
  Logger logger = Logger();

  ApiService._init();

  // MainSection GET/taskDays
  Future<List<Entity>> getAll() async {
    logger.log(Level.info, "getAll() called");
    final response = await dio.get('${Constants.serverIpAdress}/taskDays');
    logger.log(Level.info, "getAll() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(Level.error, "getAll() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // MainSection POST/task
  Future<Entity> addEntity(Entity entity) async {
    logger.log(Level.info, "addEntity() called");
    final response = await dio.post('${Constants.serverIpAdress}/task',
        data: entity.toJsonWithoutId());
    logger.log(Level.info, "addEntity() response: $response");

    if (response.statusCode == 200) {
      return Entity.fromJson(response.data);
    } else {
      logger.log(Level.error, "addEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // MainSection DELETE/task
  Future<void> deleteEntity(Entity entity) async {
    int? id = entity.id;
    logger.log(Level.info, "deleteEntity() called");
    final response = await dio.delete('${Constants.serverIpAdress}/task/$id');
    logger.log(Level.info, "deleteEntity() response: $response");

    if (response.statusCode != 200) {
      logger.log(
          Level.error, "deleteEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // MainSection GET/details
  Future<List<Entity>> getDetails(String date) async {
    logger.log(Level.info, "getDetails() called");
    final response = await dio.get(
        '${Constants.serverIpAdress}/details/$date'); // we need a new view for this that will use the entities
    logger.log(Level.info, "getDetails() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(Level.error, "getDetails() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // Progress Section & Top Section: GET/entries
  Future<List<Entity>> getEntries() async {
    logger.log(Level.info, "getEntries() called");
    final response = await dio.get('${Constants.serverIpAdress}/entries');
    logger.log(Level.info, "getEntries() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(Level.error, "getEntries() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }
}

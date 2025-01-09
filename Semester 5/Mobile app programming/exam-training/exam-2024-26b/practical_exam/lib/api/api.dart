import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/constants/constants.dart';
import 'package:practical_exam/models/entity.dart';

class ApiService {
  static final ApiService instance = ApiService._init();
  static final Dio dio = Dio();
  Logger logger = Logger();

  ApiService._init();

  // Organizer GET/events
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

  // Analytics GET/allEvents
  Future<List<Entity>> getAllEvents() async {
    logger.log(Level.info, "getAll() called");
    final response = await dio.get('${Constants.serverIpAdress}/allEvents');
    logger.log(Level.info, "getAll() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(Level.error, "getAll() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // Participant GET/inProgress
  Future<List<Entity>> getInProgress() async {
    logger.log(Level.info, "getInProgress() called");
    final response = await dio.get('${Constants.serverIpAdress}/inProgress');
    logger.log(Level.info, "getInProgress() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(
          Level.error, "getInProgress() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // Organizer GET/event
  Future<List<Entity>> getEntity() async {
    logger.log(Level.info, "getEntity() called");
    final response = await dio.get('${Constants.serverIpAdress}/event');
    logger.log(Level.info, "getEntity() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(Level.error, "getEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // Organizer POST/event
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

  // Participant PUT/enroll
  Future<void> enroll(Entity entity) async {
    logger.log(Level.info, "enroll() called");
    int? id = entity.id;
    final response =
        await dio.put('${Constants.serverIpAdress}/enroll/$id', data: entity);
    logger.log(Level.info, "enroll() response: $response");

    if (response.statusCode != 200) {
      logger.log(Level.error, "enroll() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // Organizer GET/event/id
  Future<Entity> getEntityById(Entity entity) async {
    int? id = entity.id;
    logger.log(Level.info, "getEntity() called");
    final response = await dio.get('${Constants.serverIpAdress}/event/$id');
    logger.log(Level.info, "getEntity() response: $response");

    if (response.statusCode == 200) {
      return Entity.fromJson(response.data);
    } else {
      logger.log(Level.error, "getEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }
}

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:practical_exam/constants/constants.dart';
import 'package:practical_exam/models/entity.dart';

class ApiService {
  static final ApiService instance = ApiService._init();
  static final Dio dio = Dio();
  Logger logger = Logger();

  ApiService._init();

  // Organizer GET/activities
  Future<List<Entity>> getAll() async {
    logger.log(Level.info, "getAll() called");
    final response = await dio.get('${Constants.serverIpAdress}/activities');
    logger.log(Level.info, "getAll() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(Level.error, "getAll() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // Organizer POST/activity
  Future<Entity> addEntity(Entity entity) async {
    logger.log(Level.info, "addEntity() called");
    final response = await dio.post('${Constants.serverIpAdress}/activity',
        data: entity.toJsonWithoutId());
    logger.log(Level.info, "addEntity() response: $response");

    if (response.statusCode == 200) {
      return Entity.fromJson(response.data);
    } else {
      logger.log(Level.error, "addEntity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // Organizer GET/activity/id
  Future<Entity> getActivity(Entity entity) async {
    int? id = entity.id;
    logger.log(Level.info, "getActivity() called");
    final response = await dio.get('${Constants.serverIpAdress}/activity/$id');
    logger.log(Level.info, "getActivity() response: $response");

    if (response.statusCode == 200) {
      return Entity.fromJson(response.data);
    } else {
      logger.log(Level.error, "getActivity() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

// Student GET/types
  Future<List<String>> getTypes() async {
    logger.log(Level.info, "getTypes() called");

    try {
      final response = await dio.get('${Constants.serverIpAdress}/types');
      logger.log(Level.info, "getTypes() response: $response");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data as List<dynamic>;
        final List<String> types = jsonData.map((e) => e.toString()).toList();
        return types;
      } else {
        logger.log(Level.error, "getTypes() error: ${response.statusMessage}");
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      logger.log(Level.error, "getTypes() exception: $e");
      throw Exception("Error occurred while fetching types");
    }
  }

  // Student PUT/register
  Future<void> register(String type) async {
    logger.log(Level.info, "register() called");
    final response =
        await dio.put('${Constants.serverIpAdress}/register/$type');
    logger.log(Level.info, "register() response: $response");

    if (response.statusCode != 200) {
      logger.log(Level.error, "register() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }

  // Teacher GET/participation
  Future<List<Entity>> getParticipation() async {
    logger.log(Level.info, "getParticipation() called");
    final response = await dio.get('${Constants.serverIpAdress}/participation');
    logger.log(Level.info, "getParticipation() response: $response");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Entity.fromJson(e)).toList();
    } else {
      logger.log(
          Level.error, "getParticipation() error: ${response.statusMessage}");
      throw Exception(response.statusMessage);
    }
  }
}

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../reusables/api_constants.dart';
import '../models/post_model.dart';
import '../services/sqflite_database.dart';

class FetchPostDataBloc extends Bloc<FetchPostDataEvent, FetchPostDataState> {
  FetchPostDataBloc() : super(FetchPostDataInitial()) {
    on<FetchPostData>((event, emit) async {
      emit(FetchPostDataProgress());
      if (kDebugMode) log('Called bloc', name: 'FetchPostDataBloc');
      try {
        Response response = await http.get(Uri.parse(postUrl));
        if (response.statusCode == 200) {
          final List<dynamic> postList = json.decode(response.body);
          final List<PostModel> posts = postList.map((json) => PostModel.fromJson(json)).toList();

          // Store data in SQLite
          SqfliteDatabase sqfliteDB = SqfliteDatabase();
          await sqfliteDB.clearDatabase();
          await sqfliteDB.insertPosts(posts);
          if (kDebugMode) log(response.statusCode.toString(), name: 'Post response');
          emit(FetchPostDataSuccess(posts: posts));
        } else {
          if (kDebugMode) log("Failed to fetch posts >> ${response.toString()}", name: 'Post response failed');
          emit(FetchPostDataFailure(response.statusCode));
        }
      } catch (e) {
        // Fetch from local database if API fails
        final sqfliteDB = SqfliteDatabase();
        final localPosts = await sqfliteDB.getPosts();
        if (localPosts.isNotEmpty) {
          if (kDebugMode) log("Called local db length >> ${localPosts.length}", name: 'FetchPostDataBloc');
          emit(FetchPostDataSuccess(posts: localPosts));
        } else {
          if (kDebugMode) log("Catch bloc >> ${e.toString()}", name: 'FetchPostDataBloc');
          emit(FetchPostDataFailure(e));
        }
      }
    });
  }
}

//states
abstract class FetchPostDataState {}

//events
abstract class FetchPostDataEvent {}

//states implementation
class FetchPostDataInitial extends FetchPostDataState {}

class FetchPostDataProgress extends FetchPostDataState {}

class FetchPostDataSuccess extends FetchPostDataState {
  final List<PostModel> posts;
  FetchPostDataSuccess({required this.posts});
}

class FetchPostDataFailure extends FetchPostDataState {
  final dynamic error;
  FetchPostDataFailure(this.error);
}

//events implementation
class FetchPostData extends FetchPostDataEvent {}

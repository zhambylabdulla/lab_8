import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'post_event.dart';
import 'post_state.dart';
import '../models/post.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  Future<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final posts = data.map((json) => Post.fromJson(json)).toList();
        emit(PostLoaded(posts));
      } else {
        emit(PostError('Failed to load posts'));
      }
    } catch (e) {
      emit(PostError('Error: $e'));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_8/bloc/post_bloc.dart';
import 'package:lab_8/bloc/post_event.dart';
import 'package:lab_8/bloc/post_state.dart';


class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc()..add(FetchPosts()),
      child: Scaffold(
        appBar: AppBar(title: Text('Posts')),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              );
            } else if (state is PostError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}

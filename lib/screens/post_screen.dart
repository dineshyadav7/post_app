import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../reusables/colors.dart';
import '../bloc/fetch_post_bloc.dart';
import 'post_tile.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text("Posts", style: TextStyle(color: white),),
        backgroundColor: blue,
      ),
      body: SafeArea(
        child: BlocBuilder<FetchPostDataBloc, FetchPostDataState>(
          builder: (context, fps) {
            if (fps is FetchPostDataInitial) {
              context.read<FetchPostDataBloc>().add(FetchPostData());
            }
            return fps is FetchPostDataProgress
                ? const Center(child: Text("Loading posts.."))
                : fps is FetchPostDataSuccess
                    ? ListView.builder(
                        itemCount: fps.posts.length,
                        itemBuilder: (context, index) {
                          return PostTile(post: fps.posts[index]);
                        },
                      )
                    : const Center(child: Text("No posts available"));
          },
        ),
      ),
    );
  }
}

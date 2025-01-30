import 'package:flutter/material.dart';

import '../reusables/colors.dart';
import '../models/post_model.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    super.key,
    required this.post,
  });
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          title: Text(
            post.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(post.body),
        ),
      ),
    );
  }
}

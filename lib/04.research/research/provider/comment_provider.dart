import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/model/single_comment.dart';
import 'package:intermission_project/04.research/research/repository/comment_repository.dart';

import 'package:flutter/foundation.dart';
import 'package:intermission_project/04.research/research/model/single_comment.dart';
import 'package:intermission_project/04.research/research/repository/comment_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/04.research/research/repository/research_repository.dart';
import 'package:intermission_project/04.research/research/repository/scrap_repository.dart';
import 'package:intermission_project/common/model/post_response.dart';

final commentNotifierProvider = ChangeNotifierProvider<CommentNotifier>((ref) {
  final commentRepo = ref.watch(commentRepositoryProvider);
  return CommentNotifier(commentRepo);
});

class CommentNotifier extends ChangeNotifier {
  final CommentRepository _repository;

  CommentNotifier(this._repository);

  /// 댓글 등록 하기
  Future<String> postComment(String researchId, SingleComment comment) async {
    try {
      return await _repository.postComment(researchId, comment);
    } catch (error) {
      print('Error posting comment: $error');
      throw error;
    }
  }

  // //기존 댓글 수정 하기
  // Future<String> updateComment(
  //     String commentId, SingleComment updatedComment) async {
  //   try {
  //     return await _repository.updateComment(commentId, updatedComment);
  //   } catch (error) {
  //     print('Error updating comment: $error');
  //     throw error;
  //   }
  // }

  ///(대)댓글 삭제 하기
  Future<PostResponse> deleteComment(String commentId) async {
    try {
      return await _repository.deleteComment(commentId);
    } catch (error) {
      print('Error deleting comment: $error');
      throw error;
    }
  }

  /// 대댓글 등록 하기
  Future<PostResponse> postReComment(
      String researchId, String commentId, SingleComment reComment) async {
    try {
      return await _repository.postReComment(researchId, commentId, reComment);
    } catch (error) {
      print('Error posting re-comment: $error');
      throw error;
    }
  }

  // /// 대댓글 수정하기
  // Future<String> updateReComment(
  //     String recommentId, SingleComment updatedReComment) async {
  //   try {
  //     return await _repository.updateReComment(recommentId, updatedReComment);
  //   } catch (error) {
  //     print('Error updating re-comment: $error');
  //     throw error;
  //   }
  // }

  /// 댓글 신고하기
  Future<PostResponse> reportComment(String commentId) async{
    try{
      return await _repository.reportComment(commentId);
    }catch(error){
      print('Error deleting re-comment: $error');
      throw error;
    }
  }

}

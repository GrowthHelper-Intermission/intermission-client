import 'package:intermission_project/models/cursor_pagination_model.dart';
import 'package:intermission_project/models/model_with_id.dart';
import 'package:intermission_project/models/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId>{
  Future<CursorPagination<T>> paginate({
    //retrofit에서 쿼리 추가할때
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
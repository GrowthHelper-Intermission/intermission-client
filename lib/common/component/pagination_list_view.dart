import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/model/cursor_pagination_model.dart';
import 'package:intermission_project/common/model/model_with_id.dart';
import 'package:intermission_project/common/provider/pagination_provider.dart';
import 'package:intermission_project/common/utils/pagination_utils.dart';

//3개의 파라미터를 입력받고(model은 IModelWithId를 extend한 모델)
typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;

  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    required this.provider,
    required this.itemBuilder,
    super.key,
  });

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView>
    with AutomaticKeepAliveClientMixin {
  final ScrollController controller = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(listener);
  }

  void listener() {
    PaginationUtils.paginate(
      controller: controller,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);
    //완전 처음 로딩일때
    if (state is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator(color: PRIMARY_COLOR),
      );
    }

    //에러
    if (state is CursorPaginationError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.message,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(
                    forceRefetch: true,
                  );
            },
            child: Text('다시 시도'),
          )
        ],
      );
    }

    //CursorPagination
    //CursorPaginationFetchingMore
    //CursorPaginationRefetching

    final cp = state as CursorPagination<T>;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(widget.provider.notifier).paginate(forceRefetch: true);
      },
      color: PRIMARY_COLOR,
      child: ListView.separated(
        physics: AlwaysScrollableScrollPhysics(),
        controller: controller,
        padding: const EdgeInsets.only(top: 10.0),
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            if (cp is! CursorPaginationFetchingMore) {
              if (cp.meta.hasMore) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: PRIMARY_COLOR,
                    ),
                  ),
                );
              } else {
                print('here??');
                return SizedBox.shrink(); // 아무것도 표시하지 않음
              }
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Center(child: CircularProgressIndicator(color: PRIMARY_COLOR,)),
              );
            }
          }
          final pItem = cp.data[index];
          return widget.itemBuilder(context, index, pItem);
        },
        separatorBuilder: (_, index) {
          return SizedBox(height: 0);
        },
      ),
    );
  }
}

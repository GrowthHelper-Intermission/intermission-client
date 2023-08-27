import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intermission_project/01.user/user/model/user_model.dart';
import 'package:intermission_project/01.user/user/provider/user_me_provider.dart';
import 'package:intermission_project/04.research/research/model/research_detail_model.dart';
import 'package:intermission_project/04.research/research/model/research_model.dart';
import 'package:intermission_project/04.research/research/provider/research_provider.dart';
import 'package:intermission_project/common/component/custom_appbar.dart';
import 'package:intermission_project/common/component/custom_text_style.dart';
import 'package:intermission_project/common/component/login_next_button.dart';
import 'package:intermission_project/common/component/pagination_list_view.dart';
import 'package:intermission_project/common/const/colors.dart';
import 'package:intermission_project/common/utils/pagination_utils.dart';
import 'package:intermission_project/common/view/default_layout.dart';
import 'package:skeletons/skeletons.dart';

class ResearchDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'researchDetail';
  final String id;
  const ResearchDetailScreen({
    required this.id,
    super.key,
  });

  @override
  ConsumerState<ResearchDetailScreen> createState() =>
      _ResearchDetailScreenState();
}

class _ResearchDetailScreenState extends ConsumerState<ResearchDetailScreen> {
  // final ScrollController controller = ScrollController();
  TextEditingController commentController = TextEditingController();

  int daysLeft = 0;

  bool isButtonEnabled = true;

  int _getDaysLeft(String dueDate) {
    DateTime now = DateTime.now();
    DateTime interviewDate = DateTime.parse(dueDate);
    Duration difference = interviewDate.difference(now);
    return difference.inDays + 1;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(researchProvider.notifier).getDetail(id: widget.id);
    ref.read(interviewProvider.notifier).getDetail(id: widget.id);
    ref.read(surveyProvider.notifier).getDetail(id: widget.id);
    ref.read(testerProvider.notifier).getDetail(id: widget.id);
  }

  // void listener() {
  //   //댓글로 수정
  //   PaginationUtils.paginate(
  //     controller: controller,
  //     provider: ref.read(restaurantRatingProvider(widget.id).notifier),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(researchDetailProvider(widget.id));

    // 데이터가 없거나 로딩 중인 경우
    if (state == null || state is! ResearchDetailModel) {
      return Scaffold(body: renderLoading());
    }

    // `state`가 ResearchDetailModel인 경우
    daysLeft = _getDaysLeft(state.dueDate);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () => context.go('/'), // 현재의 라우트를 1 단계 되돌립니다.
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(state),
              _buildMainContent(state),
              Divider(color: Colors.grey[200], thickness: 12.0),
              _buildDescription(state),
              Divider(color: Colors.grey[200], thickness: 12.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          _buildScrapButton(),
          Spacer(),
          LoginNextButton(onPressed: (){}, buttonName: '참여하기', isButtonEnabled: true),
        ],
      ),
    );
  }

  Widget _buildScrapButton() {
    // 스크랩 버튼 디자인. 실제 디자인에 맞게 수정이 필요합니다.
    return IconButton(
      icon: Icon(Icons.bookmark_border),
      onPressed: () {
        // 스크랩 버튼 클릭 시의 로직
      },
    );
  }

  Widget _buildHeader(ResearchDetailModel state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _mapResearchTypeToText(state.researchType),
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          width: 38,
          height: 21,
          decoration: BoxDecoration(
            color: daysLeft <= 3 ? Colors.white : SUB_BLUE_COLOR,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: SUB_BLUE_COLOR,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              'D-$daysLeft',
              style: TextStyle(
                color: daysLeft <= 3 ? SUB_BLUE_COLOR : Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent(ResearchDetailModel state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Text(state.mainTitle, style: customTextStyle),
        SizedBox(height: 5),
        Text(state.subTitle, style: whiteSmallTextStyle),
        SizedBox(height: 5),
        Row(
          children: [
            Text(state.researchMethTpCd, style: whiteSmallTextStyle),
            Text(' | ', style: whiteSmallTextStyle),
            Text('${state.exceptTime}시간 ', style: whiteSmallTextStyle),
            Text(state.researchRewdAmt, style: whiteSmallTextStyle),
          ],
        ),
        _buildInfoContainer(state),
        _buildParticipationInfo(state),
      ],
    );
  }

  Widget _buildInfoContainer(ResearchDetailModel state) {
    return Center(
      child: Container(
        width: 355,
        height: 110,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.grey.shade200,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRowInfo('예상 소요시간', '${state.exceptTime}시간'),
            _buildRowInfo('마감일', state.dueDate),
            _buildRowInfo('최소 참여 요건', '${state.minAge}'),
          ],
        ),
      ),
    );
  }

  Widget _buildRowInfo(String title, String value) {
    const double titleWidth = 80.0;  // 원하는 title의 넓이를 지정합니다.
    const double valueWidth = 200.0;  // 원하는 value의 넓이를 지정합니다.

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 5),
      child: Row(
        children: [
          Container(
            width: titleWidth,
            child: Text(title, style: whiteSmallTextStyle),
          ),
          Expanded(child: SizedBox.shrink()), // to push the next text to the end
          Container(
            width: valueWidth,
            child: Text(value, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildParticipationInfo(ResearchDetailModel state) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.check,
                size: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 8.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '현재 ', style: whiteMiddleTextStyle),
                TextSpan(
                  text: '${state.researchCnt}',
                  style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.w700),
                ),
                TextSpan(text: '명이 참여했어요!', style: whiteMiddleTextStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(ResearchDetailModel state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text('설명'),
          Text(state.detail),
        ],
      ),
    );
  }


  String _mapResearchTypeToText(String researchType) {
    switch (researchType) {
      case 'survey':
        return '설문조사';
      case 'interview':
        return '인터뷰';
      case 'test':
        return '테스트 참여';
      default:
        return researchType; // 기본값을 반환 (혹은 다른 기본 문자열을 지정해도 좋습니다)
    }
  }

  // 로딩 위젯을 Sliver가 아닌 일반 Padding 위젯으로 변경
  Widget renderLoading() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Column(
        children: List.generate(
          3,
              (index) => Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: SkeletonParagraph(
              style: SkeletonParagraphStyle(
                lines: 5,
                padding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

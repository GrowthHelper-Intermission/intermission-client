import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

class UserModelLoading extends UserModelBase {}

class UserModelSuccess extends UserModelBase {}

@JsonSerializable()
class UserModel extends UserModelBase{
  // /// 회원번호(Server)
  // final String id;

  /// 회원 구분 코드
  final String userTpCd;

  /// 회원명
  final String userNm;

  /// 회원ID
  final String userId;

  // /// 비밀번호
  // final String pwd;

  /// 가입일자
  final String joinDay;

  /// 회원 은행(차후 enum 변경)
  final String bankAccount;

  /// 계좌번호
  final String accountNumber;

  /// 생년월일
  final String birthDay;

  /// 성별코드(차후 enum 변경)
  final String genderCd;

  /// 핸드폰 번호, 6개 종류였던거 일단 1개로 축약
  final String hpNum;

  /// EMAIL주소
  final String email;

  /// EMAIL인증여부
  final String emailVerfYn;

  /// 직업코드(일단 직업명 그대로 적기. 차후 enum 변경. 10초등, 15)
  /// 10(초등학생), 11(중학생), 12(고등학생), 13(대학생), 14(대학원생),
  /// 15(직장인), 16(유학생), 17(공무원), 18(군인), 99(기타)
  final String jobCd;

  /// 담당업무코드(선택)
  /// 10(일반사무직), 20(재무/경리), 30(영업직), 40(홍보/마케팅),
  /// 50(기획), 60(IT-기획), 70(IT-개발), 99(기타) 추가 생성 가
  final String asignJobCd;

  // final String jobGrdNm;

  /// 결혼구분코드(차후 enum 변경(Y/N, Default = 'N'))
  final String wedTpCd;

  /// 주거형태코드(차후 enum 변경(1인가구, 2인가구, 3인가구, 4인가구, 5인가구, 6인가구 이상, 기타))
  final String housTpCd;

  /// 반려동물여부((Y/N, Default = 'N')
  final String petYn;

  /// 반려동물구분코드(차후 enum 변경(강아지(1), 고양이(2), 기타(9)))
  final String petTpCd;

  /// 반려동물명(petTpCd 9인 기타인 경우 기입)
  final String petNm;

  /// 주거지역시도코드
  final String occpSidoCd;

  /// 주거지역시군구코드
  final String occpSigunguCd;

  /// 인터뷰지역시도코드
  final String intvSidoCd;

  /// 인터뷰지역시군구코드
  final String intvSigunguCd;

  /// 1시간비대면인터뷰보상구분코드
  final String oflIntvRwdTpCd;

  /// 1시간대면인터뷰보상구분코드
  final String onlIntvRwdTpCd;

  /// 주이용온라인서비스내용
  final String mainUseOnlSvcCn;

  // /// 취미내용
  // final String hobySubs;

  // /// 추천회원번호
  // final String rcmdUserCd;

  /// 개인정보수집동의여부(Y/N, Default = 'Y')
  final String isAgreeYn;

  /// 개인정보수집동일시 => DateTime
  final String isAgreeDt;

  /// 직원여부(직원이 회원일 경우 매칭 대상에서 제외하기 위하여 생성)
  final String empYn;

  /// 사원번호(직원일시만 입력. 1000000부터 시작하여 사원 등록 시 자동 증가)
  final String empNo;

  /// 삭제여부(물리적인 데이터 삭제는 없으며, Flag 처리)
  final String delYn;

  /// 최초 입력 일시(최초 계정 회원가입한 시간) => DateTime
  final String frstRegtDt;

  /// 최종수정일시(회원정보 최종 수정 시간) => DateTime
  final String finlUpdtDt;

  UserModel({
    // required this.id,
    required this.userTpCd,
    required this.userNm,
    required this.userId,
    // required this.pwd,
    required this.joinDay,
    required this.bankAccount,
    required this.accountNumber,
    required this.birthDay,
    required this.genderCd,
    required this.hpNum,
    required this.email,
    required this.emailVerfYn,
    required this.jobCd,
    required this.asignJobCd,
    // required this.jobGrdNm,
    required this.wedTpCd,
    required this.housTpCd,
    required this.petYn,
    required this.petTpCd,
    required this.petNm,
    required this.occpSidoCd,
    required this.occpSigunguCd,
    required this.intvSidoCd,
    required this.intvSigunguCd,
    required this.oflIntvRwdTpCd,
    required this.onlIntvRwdTpCd,
    required this.mainUseOnlSvcCn,
    // required this.hobySubs,
    // required this.rcmdUserCd,
    required this.isAgreeYn,
    required this.isAgreeDt,
    required this.empYn,
    required this.empNo,
    required this.delYn,
    required this.frstRegtDt,
    required this.finlUpdtDt,
  });

  UserModel copyWith({
    String? userTpCd,
    String? userNm,
    String? userId,
    // String? pwd,
    String? joinDay,
    String? bankAccount,
    String? accountNumber,
    String? birthDay,
    String? genderCd,
    String? hpNum,
    String? email,
    String? emailVerfYn,
    String? jobCd,
    String? asignJobCd,
    // String? jobGrdNm,
    String? wedTpCd,
    String? housTpCd,
    String? petYn,
    String? petTpCd,
    String? petNm,
    //거주지역 코드
    String? occpSidoCd,
    String? occpSigunguCd,
    String? intvSidoCd,
    String? intvSigunguCd,
    //보상
    String? oflIntvRwdTpCd,
    String? onlIntvRwdTpCd,
    String? mainUseOnlSvcCn,
    //취미
    String? hobySubs,
    //추천인
    String? rcmdUserCd,
    //동의 여부
    String? isAgreeYn,
    String? isAgreeDt,
    //사원 여부
    String? empYn,
    String? empNo,
    //강제 삭제 OR 탈퇴
    String? delYn,
    //등록 날짜
    String? frstRegtDt,
    String? finlUpdtDt,
  }) {
    return UserModel(
      userTpCd: userTpCd ?? '',
      userNm: userNm ?? this.userNm,
      userId: userId ?? this.userId,
      // pwd: pwd ?? '',
      joinDay: joinDay ?? this.joinDay,
      bankAccount: bankAccount ?? this.bankAccount,
      accountNumber: accountNumber ?? this.accountNumber,
      birthDay: birthDay ?? this.birthDay,
      genderCd: genderCd ?? this.genderCd,
      hpNum: hpNum ?? this.hpNum,
      email: email ?? this.email,
      emailVerfYn: emailVerfYn ?? this.emailVerfYn,
      jobCd: jobCd ?? this.jobCd,
      asignJobCd: asignJobCd ?? this.asignJobCd,
      // jobNm: jobNm ?? this.jobNm,
      wedTpCd: wedTpCd ?? this.wedTpCd,
      housTpCd: housTpCd ?? this.housTpCd,
      petYn: petYn ?? this.petYn,
      petTpCd: petTpCd ?? this.petTpCd,
      petNm: petNm ?? this.petNm,
      occpSidoCd: occpSidoCd ?? this.occpSidoCd,
      occpSigunguCd: occpSigunguCd ?? this.occpSigunguCd,
      intvSidoCd: intvSidoCd ?? this.intvSidoCd,
      intvSigunguCd: intvSigunguCd ?? this.intvSigunguCd,
      oflIntvRwdTpCd: oflIntvRwdTpCd ?? '',
      onlIntvRwdTpCd: onlIntvRwdTpCd ?? '',
      mainUseOnlSvcCn: mainUseOnlSvcCn ?? '',
      // hobySubs: hobySubs ?? this.hobySubs ?? '',
      // rcmdUserCd: rcmdUserCd ?? this.rcmdUserCd,
      isAgreeYn: isAgreeYn ?? this.isAgreeYn,
      isAgreeDt: isAgreeDt ?? this.isAgreeDt,
      empYn: empYn ?? this.empYn,
      empNo: empNo ?? this.empNo,
      delYn: delYn ?? this.delYn,
      frstRegtDt: frstRegtDt ?? this.frstRegtDt,
      finlUpdtDt: finlUpdtDt ?? this.finlUpdtDt,
    );
  }


  factory UserModel.fromJson(Map<String, dynamic> json)
  => _$UserModelFromJson(json);

  Map<String,dynamic> toJson() => _$UserModelToJson(this);

}

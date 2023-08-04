// enum BankRange {
//   hana,
//   sc,
//   kyongnam,
//   kwangju,
//   kookmin,
//   kiup,
//   nonghyup,
//   daegu,
//   busan,
//   sanup,
//   saemaeul,
//   suhyup,
//   shinhan,
//   shinhyup,
//   city,
//   woori,
//   post,
//   jeonbuk,
//   jeju,
//   kakaoBank,
//   kBank,
//   tossBank,
// }
//
// enum Gender {
//   male,
//   female,
// }
//
// enum MaritalStatus {
//   single,
//   married,
// }
//
// abstract class UserModelBase {}
//
// class UserModelError extends UserModelBase {
//   final String message;
//
//   UserModelError({
//     required this.message,
//   });
// }
//
// class UserModelLoading extends UserModelBase {}
//
// class UserModel extends UserModelBase {
//   final String userId; //ex) "1952a209-7c26-4f50-bc65-086f6e64dbbd"
//   //email -> 사용자 고유 ID(중복될 영향 X)
//   final String emailAccount;
//   final String password;
//   final String name;
//   //계정 생성 시간
//   final String createdTime;
//   //성별(ENUM male, female)
//   final Gender gender;
//   //결혼 여부(ENUM Single, married)
//   final MaritalStatus isMarried;
//   final String phoneNumber;
//   final int age;
//   final String job;
//   //펫 기르는지 여부
//   final bool isRaisePet;
//   //기른다면 종류는?
//   final String kindOfPet;
//   //거주 유형
//   final String residenceType;
//   //거주 지역
//   final String residenceArea;
//   //인터뷰 가능 지역
//   final String interviewPossibleArea;
//   final String interviewReward;
//   final String oftenUsingService;
//   final String hobby;
//   final String recommendWho;
//   final int userPoint;
//   final bool isAgree;
// //사용 은행(ENUM 하나,기업...)
//   final BankRange userBankAccount;
// //계좌 번호
//   final String accountNumber;
//   final bool emailVerified;
// //스크랩 인터뷰 ID 리스트
//   final List<String> scrapedInterviews;
// //참여한 인터뷰 ID 리스트
//   final List<String> participatedInterviews;
// //작성한 인터뷰 ID 리스트
//   final List<String> requestedInterviews;
//   UserModel({
//     required this.userId,
//     required this.emailAccount,
//     required this.password,
//     required this.name,
//     required this.createdTime,
//     required this.gender,
//     required this.isMarried,
//     required this.phoneNumber,
//     required this.age,
//     required this.job,
//     required this.isRaisePet,
//     required this.kindOfPet,
//     required this.residenceType,
//     required this.residenceArea,
//     required this.interviewPossibleArea,
//     required this.interviewReward,
//     required this.oftenUsingService,
//     required this.hobby,
//     required this.recommendWho,
//     required this.userPoint,
//     required this.isAgree,
//     required this.userBankAccount,
//     required this.accountNumber,
//     required this.emailVerified,
//     required this.scrapedInterviews,
//     required this.participatedInterviews,
//     required this.requestedInterviews,
//   });
// }


import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';


enum GenderCd { A1,A2,A3 }
enum UserTpCd{A1,A2,A3,A4,A9}
//10(초등학생), 11(중학생), 12(고등학생), 13(대학생), 14(대학원생),
// 15(직장인), 16(유학생), 17(공무원), 18(군인), 99(기타)
enum JobCd { A10,A11,A12,A13,A14,A15,A16,A17,A18,A19 }
enum WedTpCd { A1,A2,A3,A4 }
enum HousTpCd { A1,A2,A3,A4,A5,A6,A7 }
enum PetTpCd { A1,A2,A3,A9 }
enum IsAgreeYn { T, F }

enum BankRange {
  hana,
  sc,
  kyongnam,
  kwangju,
  kookmin,
  kiup,
  nonghyup,
  daegu,
  busan,
  sanup,
  saemaeul,
  suhyup,
  shinhan,
  shinhyup,
  city,
  woori,
  post,
  jeonbuk,
  jeju,
  kakaoBank,
  kBank,
  tossBank,
}

@JsonSerializable()
class UserModel {
  /// 회원번호
  final String userNo;

  /// 회원 구분 코드
  final String userTpCd;

  /// 회원명
  final String userNm;

  /// 회원ID
  final String userId;

  /// 비밀번호
  final String pwd;

  /// 가입일자
  final String joinDay;

  /// 회원 은행
  final BankRange bankAccount;

  /// 계좌번호
  final String accountNumber;

  /// 생년월일
  final String birthDay;

  /// 성별코드
  final GenderCd genderCd;

  /// 핸트폰사업자번호
  final String hpBizNo;

  /// 핸드폰국번호
  final String hpExchgNo;

  /// 핸드폰회선번호
  final String hpLineNo;

  /// 유선전화지역번호
  final String cablePhonAreaNo;

  /// 유선전화국번호
  final String cablePhonExchgNo;

  /// 유선전화회선번호
  final String cablePhonLineNo;

  /// EMAIL주소
  final String email;

  /// EMAIL인증여부
  final String emailVerfYn;

  /// 직업코드
  final JobCd jobCd;

  /// 직장명
  final String ofcNm;

  /// 직급명
  final String jobGrdNm;

  /// 담당업무코드
  final String asignJobCd;

  /// 대표자여부
  final String ceoYn;

  /// 결혼구분코드
  final WedTpCd wedTpCd;

  /// 주거형태코드
  final HousTpCd housTpCd;

  /// 반려동물여부
  final String petYn;

  /// 반려동물구분코드
  final PetTpCd petTpCd;

  /// 반려동물명
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

  /// 취미내용
  final String hobySubs;

  /// 추천회원번호
  final String rcmdUserCd;

  /// 개인정보수집동의여부
  final IsAgreeYn isAgreeYn;

  /// 개인정보수집동일시 => DateTime
  final DateTime isAgreeDt;

  /// 직원여부
  final String empYn;

  /// 사원번호
  final String empNo;

  /// 삭제여부
  final String delYn;

  /// 최초 입력 일시(최초 계정 회원가입한 시간) => DateTime
  final DateTime frstRegtDt;

  /// 최종수정일시(회원정보 최종 수정 시간) => DateTime
  final DateTime finlUpdtDt;

  UserModel({
    required this.userNo,
    required this.userTpCd,
    required this.userNm,
    required this.userId,
    required this.pwd,
    required this.joinDay,
    required this.bankAccount,
    required this.accountNumber,
    required this.birthDay,
    required this.genderCd,
    required this.hpBizNo,
    required this.hpExchgNo,
    required this.hpLineNo,
    required this.cablePhonAreaNo,
    required this.cablePhonExchgNo,
    required this.cablePhonLineNo,
    required this.email,
    required this.emailVerfYn,
    required this.jobCd,
    required this.ofcNm,
    required this.jobGrdNm,
    required this.asignJobCd,
    required this.ceoYn,
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
    required this.hobySubs,
    required this.rcmdUserCd,
    required this.isAgreeYn,
    required this.isAgreeDt,
    required this.empYn,
    required this.empNo,
    required this.delYn,
    required this.frstRegtDt,
    required this.finlUpdtDt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json)
  => _$UserModelFromJson(json);

  Map<String,dynamic> toJson() => _$UserModelToJson(this);

}

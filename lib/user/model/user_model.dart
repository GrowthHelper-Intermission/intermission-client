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

enum Gender {
  male,
  female,
}

enum MaritalStatus {
  single,
  married,
}

abstract class UserModelBase {}

class UserModelError extends UserModelBase {
  final String message;

  UserModelError({
    required this.message,
  });
}

class UserModelLoading extends UserModelBase {}

class UserModel extends UserModelBase {
  final String userId; //ex) "1952a209-7c26-4f50-bc65-086f6e64dbbd"
  //email -> 사용자 고유 ID(중복될 영향 X)
  final String emailAccount;
  final String password;
  final String name;
  //계정 생성 시간
  final String createdTime;
  //성별(ENUM male, female)
  final Gender gender;
  //결혼 여부(ENUM Single, married)
  final MaritalStatus isMarried;
  final String phoneNumber;
  final int age;
  final String job;
  //펫 기르는지 여부
  final bool isRaisePet;
  //기른다면 종류는?
  final String kindOfPet;
  //거주 유형
  final String residenceType;
  //거주 지역
  final String residenceArea;
  //인터뷰 가능 지역
  final String interviewPossibleArea;
  final String interviewReward;
  final String oftenUsingService;
  final String hobby;
  final String recommendWho;
  final int userPoint;
  final bool isAgree;
//사용 은행(ENUM 하나,기업...)
  final BankRange userBankAccount;
//계좌 번호
  final String accountNumber;
  final bool emailVerified;
//스크랩 인터뷰 ID 리스트
  final List<String> scrapedInterviews;
//참여한 인터뷰 ID 리스트
  final List<String> participatedInterviews;
//작성한 인터뷰 ID 리스트
  final List<String> requestedInterviews;
  UserModel({
    required this.userId,
    required this.emailAccount,
    required this.password,
    required this.name,
    required this.createdTime,
    required this.gender,
    required this.isMarried,
    required this.phoneNumber,
    required this.age,
    required this.job,
    required this.isRaisePet,
    required this.kindOfPet,
    required this.residenceType,
    required this.residenceArea,
    required this.interviewPossibleArea,
    required this.interviewReward,
    required this.oftenUsingService,
    required this.hobby,
    required this.recommendWho,
    required this.userPoint,
    required this.isAgree,
    required this.userBankAccount,
    required this.accountNumber,
    required this.emailVerified,
    required this.scrapedInterviews,
    required this.participatedInterviews,
    required this.requestedInterviews,
  });
}

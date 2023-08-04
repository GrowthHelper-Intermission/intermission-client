// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userNo: json['userNo'] as String,
      userTpCd: json['userTpCd'] as String,
      userNm: json['userNm'] as String,
      userId: json['userId'] as String,
      pwd: json['pwd'] as String,
      joinDay: json['joinDay'] as String,
      bankAccount: $enumDecode(_$BankRangeEnumMap, json['bankAccount']),
      accountNumber: json['accountNumber'] as String,
      birthDay: json['birthDay'] as String,
      genderCd: $enumDecode(_$GenderCdEnumMap, json['genderCd']),
      hpBizNo: json['hpBizNo'] as String,
      hpExchgNo: json['hpExchgNo'] as String,
      hpLineNo: json['hpLineNo'] as String,
      cablePhonAreaNo: json['cablePhonAreaNo'] as String,
      cablePhonExchgNo: json['cablePhonExchgNo'] as String,
      cablePhonLineNo: json['cablePhonLineNo'] as String,
      email: json['email'] as String,
      emailVerfYn: json['emailVerfYn'] as String,
      jobCd: $enumDecode(_$JobCdEnumMap, json['jobCd']),
      ofcNm: json['ofcNm'] as String,
      jobGrdNm: json['jobGrdNm'] as String,
      asignJobCd: json['asignJobCd'] as String,
      ceoYn: json['ceoYn'] as String,
      wedTpCd: $enumDecode(_$WedTpCdEnumMap, json['wedTpCd']),
      housTpCd: $enumDecode(_$HousTpCdEnumMap, json['housTpCd']),
      petYn: json['petYn'] as String,
      petTpCd: $enumDecode(_$PetTpCdEnumMap, json['petTpCd']),
      petNm: json['petNm'] as String,
      occpSidoCd: json['occpSidoCd'] as String,
      occpSigunguCd: json['occpSigunguCd'] as String,
      intvSidoCd: json['intvSidoCd'] as String,
      intvSigunguCd: json['intvSigunguCd'] as String,
      oflIntvRwdTpCd: json['oflIntvRwdTpCd'] as String,
      onlIntvRwdTpCd: json['onlIntvRwdTpCd'] as String,
      mainUseOnlSvcCn: json['mainUseOnlSvcCn'] as String,
      hobySubs: json['hobySubs'] as String,
      rcmdUserCd: json['rcmdUserCd'] as String,
      isAgreeYn: $enumDecode(_$IsAgreeYnEnumMap, json['isAgreeYn']),
      isAgreeDt: DateTime.parse(json['isAgreeDt'] as String),
      empYn: json['empYn'] as String,
      empNo: json['empNo'] as String,
      delYn: json['delYn'] as String,
      frstRegtDt: DateTime.parse(json['frstRegtDt'] as String),
      finlUpdtDt: DateTime.parse(json['finlUpdtDt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'userNo': instance.userNo,
      'userTpCd': instance.userTpCd,
      'userNm': instance.userNm,
      'userId': instance.userId,
      'pwd': instance.pwd,
      'joinDay': instance.joinDay,
      'bankAccount': _$BankRangeEnumMap[instance.bankAccount]!,
      'accountNumber': instance.accountNumber,
      'birthDay': instance.birthDay,
      'genderCd': _$GenderCdEnumMap[instance.genderCd]!,
      'hpBizNo': instance.hpBizNo,
      'hpExchgNo': instance.hpExchgNo,
      'hpLineNo': instance.hpLineNo,
      'cablePhonAreaNo': instance.cablePhonAreaNo,
      'cablePhonExchgNo': instance.cablePhonExchgNo,
      'cablePhonLineNo': instance.cablePhonLineNo,
      'email': instance.email,
      'emailVerfYn': instance.emailVerfYn,
      'jobCd': _$JobCdEnumMap[instance.jobCd]!,
      'ofcNm': instance.ofcNm,
      'jobGrdNm': instance.jobGrdNm,
      'asignJobCd': instance.asignJobCd,
      'ceoYn': instance.ceoYn,
      'wedTpCd': _$WedTpCdEnumMap[instance.wedTpCd]!,
      'housTpCd': _$HousTpCdEnumMap[instance.housTpCd]!,
      'petYn': instance.petYn,
      'petTpCd': _$PetTpCdEnumMap[instance.petTpCd]!,
      'petNm': instance.petNm,
      'occpSidoCd': instance.occpSidoCd,
      'occpSigunguCd': instance.occpSigunguCd,
      'intvSidoCd': instance.intvSidoCd,
      'intvSigunguCd': instance.intvSigunguCd,
      'oflIntvRwdTpCd': instance.oflIntvRwdTpCd,
      'onlIntvRwdTpCd': instance.onlIntvRwdTpCd,
      'mainUseOnlSvcCn': instance.mainUseOnlSvcCn,
      'hobySubs': instance.hobySubs,
      'rcmdUserCd': instance.rcmdUserCd,
      'isAgreeYn': _$IsAgreeYnEnumMap[instance.isAgreeYn]!,
      'isAgreeDt': instance.isAgreeDt.toIso8601String(),
      'empYn': instance.empYn,
      'empNo': instance.empNo,
      'delYn': instance.delYn,
      'frstRegtDt': instance.frstRegtDt.toIso8601String(),
      'finlUpdtDt': instance.finlUpdtDt.toIso8601String(),
    };

const _$BankRangeEnumMap = {
  BankRange.hana: 'hana',
  BankRange.sc: 'sc',
  BankRange.kyongnam: 'kyongnam',
  BankRange.kwangju: 'kwangju',
  BankRange.kookmin: 'kookmin',
  BankRange.kiup: 'kiup',
  BankRange.nonghyup: 'nonghyup',
  BankRange.daegu: 'daegu',
  BankRange.busan: 'busan',
  BankRange.sanup: 'sanup',
  BankRange.saemaeul: 'saemaeul',
  BankRange.suhyup: 'suhyup',
  BankRange.shinhan: 'shinhan',
  BankRange.shinhyup: 'shinhyup',
  BankRange.city: 'city',
  BankRange.woori: 'woori',
  BankRange.post: 'post',
  BankRange.jeonbuk: 'jeonbuk',
  BankRange.jeju: 'jeju',
  BankRange.kakaoBank: 'kakaoBank',
  BankRange.kBank: 'kBank',
  BankRange.tossBank: 'tossBank',
};

const _$GenderCdEnumMap = {
  GenderCd.A1: 'A1',
  GenderCd.A2: 'A2',
  GenderCd.A3: 'A3',
};

const _$JobCdEnumMap = {
  JobCd.A10: 'A10',
  JobCd.A11: 'A11',
  JobCd.A12: 'A12',
  JobCd.A13: 'A13',
  JobCd.A14: 'A14',
  JobCd.A15: 'A15',
  JobCd.A16: 'A16',
  JobCd.A17: 'A17',
  JobCd.A18: 'A18',
  JobCd.A19: 'A19',
};

const _$WedTpCdEnumMap = {
  WedTpCd.A1: 'A1',
  WedTpCd.A2: 'A2',
  WedTpCd.A3: 'A3',
  WedTpCd.A4: 'A4',
};

const _$HousTpCdEnumMap = {
  HousTpCd.A1: 'A1',
  HousTpCd.A2: 'A2',
  HousTpCd.A3: 'A3',
  HousTpCd.A4: 'A4',
  HousTpCd.A5: 'A5',
  HousTpCd.A6: 'A6',
  HousTpCd.A7: 'A7',
};

const _$PetTpCdEnumMap = {
  PetTpCd.A1: 'A1',
  PetTpCd.A2: 'A2',
  PetTpCd.A3: 'A3',
  PetTpCd.A9: 'A9',
};

const _$IsAgreeYnEnumMap = {
  IsAgreeYn.T: 'T',
  IsAgreeYn.F: 'F',
};

import 'package:opennutritracker/core/data/dbo/user_dbo.dart';
import 'package:opennutritracker/core/domain/entity/user_gender_entity.dart';
import 'package:opennutritracker/core/domain/entity/user_pal_entity.dart';
import 'package:opennutritracker/core/domain/entity/user_role_entity.dart';
import 'package:opennutritracker/core/domain/entity/user_weight_goal_entity.dart';

class UserEntity {
  DateTime birthday;
  double heightCM;
  double weightKG;
  UserGenderEntity gender;
  UserWeightGoalEntity goal;
  UserPALEntity pal;
  UserRoleEntity userRole;

  UserEntity({
    required this.birthday,
    required this.heightCM,
    required this.weightKG,
    required this.gender,
    required this.goal,
    required this.pal,
    required this.userRole,
  });

  factory UserEntity.fromUserDBO(UserDBO userDBO) {
    return UserEntity(
      birthday: userDBO.birthday,
      heightCM: userDBO.heightCM,
      weightKG: userDBO.weightKG,
      gender: UserGenderEntity.fromUserGenderDBO(userDBO.gender),
      goal: UserWeightGoalEntity.fromUserWeightGoalDBO(userDBO.goal),
      pal: UserPALEntity.fromUserPALDBO(userDBO.pal),
      userRole: UserRoleEntity.values.firstWhere(
          (element) => element.toString() == userDBO.userRole,
          orElse: () => UserRoleEntity.unspecified),
    );
  }

  UserEntity copyWith({
    DateTime? birthday,
    double? heightCM,
    double? weightKG,
    UserGenderEntity? gender,
    UserWeightGoalEntity? goal,
    UserPALEntity? pal,
    UserRoleEntity? userRole,
  }) {
    return UserEntity(
      birthday: birthday ?? this.birthday,
      heightCM: heightCM ?? this.heightCM,
      weightKG: weightKG ?? this.weightKG,
      gender: gender ?? this.gender,
      goal: goal ?? this.goal,
      pal: pal ?? this.pal,
      userRole: userRole ?? this.userRole,
    );
  }

  int get age => DateTime.now().difference(birthday).inDays ~/ 365;
}

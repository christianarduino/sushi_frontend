import 'package:sushi/model/Store/User.dart';
import 'package:sushi/utils/enum.dart';
import 'package:sushi/utils/field_user.dart';

enum NewGroupActions {
  SelectNameAndDesc,
  AddMember,
  RemoveMember,
  ResetMember,
  SelectLocal,
  SelectPayment,
  RemoveUsers,
}

class SelectNameAndDesc {
  final FieldUser payload;
  final NewGroupActions type = NewGroupActions.SelectNameAndDesc;

  SelectNameAndDesc(this.payload);
}

class AddMember {
  final User payload;
  final NewGroupActions type = NewGroupActions.AddMember;

  AddMember(this.payload);
}

class RemoveMember {
  final User payload;
  final NewGroupActions type = NewGroupActions.RemoveMember;

  RemoveMember(this.payload);
}

class ResetMember {
  final NewGroupActions type = NewGroupActions.ResetMember;
}

class SelectLocal {
  final String payload;
  final NewGroupActions type = NewGroupActions.SelectLocal;

  SelectLocal(this.payload);
}

class SelectPayment {
  final PaymentType payload;
  final NewGroupActions type = NewGroupActions.SelectPayment;

  SelectPayment(this.payload);
}

class RemoveUsers {
  final NewGroupActions type = NewGroupActions.RemoveUsers;
}

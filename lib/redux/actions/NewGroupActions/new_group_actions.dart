import 'package:sushi/model/Store/User.dart';
import 'package:sushi/screens/CreateGroup/create_group_page.dart';
import 'package:sushi/utils/field_user.dart';

enum NewGroupActions {
  SelectNameAndDesc,
  AddMember,
  RemoveMember,
  SelectLocal,
  SelectPayment,
  RemoveGroup,
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

class RemoveGroup {
  final NewGroupActions type = NewGroupActions.RemoveGroup;
}

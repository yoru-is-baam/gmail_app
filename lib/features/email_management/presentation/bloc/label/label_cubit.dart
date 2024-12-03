import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gmail_app/core/constants/label.dart';
import 'package:gmail_app/features/email_management/presentation/bloc/label/label_state.dart';

class LabelCubit extends Cubit<LabelState> {
  LabelCubit() : super(LabelState(Label.inbox));

  void updateLabel(Label label) {
    emit(LabelState(label));
  }
}

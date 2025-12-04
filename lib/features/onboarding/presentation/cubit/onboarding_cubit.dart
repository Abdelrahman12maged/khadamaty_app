import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void changePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  void nextPage() {
    if (!state.isLastPage) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    }
  }

  void skipToEnd() {
    emit(state.copyWith(currentPage: state.totalPages - 1));
  }

  void reset() {
    emit(const OnboardingState());
  }
}

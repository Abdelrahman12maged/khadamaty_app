import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Navigation state
/// Uses Equatable to prevent unnecessary rebuilds
class NavigationState extends Equatable {
  final int selectedIndex;

  const NavigationState({this.selectedIndex = 0});

  NavigationState copyWith({int? selectedIndex}) {
    return NavigationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object> get props => [selectedIndex];
}

/// Navigation cubit for managing navigation state
class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit({int initialIndex = 0})
      : super(NavigationState(selectedIndex: initialIndex));

  void selectPage(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}

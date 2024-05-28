import 'package:hydrated_bloc/hydrated_bloc.dart';

class BottomNavCubit extends HydratedCubit<int> {
  BottomNavCubit() : super(0);

  void updateIndex(int index) => emit(index);

  void getHomeScreen() => emit(0);
  void getWardrobeScreen() => emit(1);
  void getWishlistScreen() => emit(2);
  void getFeedbackScreen() => emit(3);
  void getProfileScreen() => emit(4);

  @override
  int? fromJson(Map<String, dynamic> json) {
    return json['pageIndex'] as int?;
  }

  @override
  Map<String, dynamic>? toJson(int state) {
    return <String, int>{'pageIndex': state};
  }
}

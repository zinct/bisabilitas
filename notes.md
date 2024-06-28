# For watch image resolution

```
flutter packages pub run image_res:main watch
```

# For watch freezed file

```
dart run build_runner watch --delete-conflicting-outputs
```

# For change package application name

```
flutter pub run change_app_package_name:main com.piknikaja.piknikaja
```

# For build android apk based on flavors

```
flutter build apk --flavor development -t lib/main_development.dart
flutter build apk --flavor production -t lib/main_production.dart
```

# For build android app bundle based on flavors

```
flutter build appbundle --flavor development -t lib/main_development.dart
flutter build appbundle --flavor production -t lib/main_production.dart
```

# For showing error view

```
else if (state.status == SliderStatus.error) {
  return PrimaryErrorView(
    error: state.error!,
    height: 130.w,
    onRefresh: () {
      context.read<SliderCubit>().getData();
    },
  );
}
```

# For getting argument from route context

```
final args = ModalRoute.of(context)!.settings.arguments as UserEntity;
```

# For showing flutter toast

```
Fluttertoast.showToast(
  msg: state.dynamicLikedError!.shortMessage,
  fontSize: 13.sp,
  backgroundColor: BaseColors.danger,
  timeInSecForIosWeb: 2,
);
```

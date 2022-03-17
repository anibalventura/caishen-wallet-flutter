# Caishen Wallet

[![Flutter](https://img.shields.io/static/v1?label=Flutter&message=2.10.1&color=blue)](https://flutter.dev/)
[![Null Safety](https://img.shields.io/static/v1?label=Null+Safety&message=YES&color=success)](https://flutter.dev/docs/null-safety)
[![Flutter Support](https://img.shields.io/static/v1?label=Support&message=Android%20|%20iOS&color=blue)]()
[![Lint: very good analysis](https://img.shields.io/badge/Lint-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
[![License](https://img.shields.io/static/v1?label=License&message=MIT&color=blue)](LICENSE)

<!-- <img src="assets/images/repository/repository_banner.png" align="center"/> -->

Spending tracker app with [Firebase](https://firebase.google.com) as backend and MVC architecture pattern.

## Features

- Login and register a new user with email and password.
- Logout current user.
- Create and see transactions.
- Localization (English/Spanish).

### TODO

- [] App icon, splash screen and night mode.
- [] Dashboard screen.
- [] Profile screen.
- [] Filter transactions.
- [] CRUD payment list.
- [] CRUD category list.
- [] CRUD category list.

## Development

| Dependencies                                                                    | <!-- -->                                                        |
| ------------------------------------------------------------------------------- | --------------------------------------------------------------- |
| [animated_text_kit](https://pub.dev/packages/animated_text_kit)                 | [cloud_firestore](https://pub.dev/packages/cloud_firestore)     |
| [cupertino_icons](https://pub.dev/packages/cupertino_icons)                     | [easy_localization](https://pub.dev/packages/easy_localization) |
| [firebase_auth](https://pub.dev/packages/firebase_auth)                         | [firebase_core](https://pub.dev/packages/firebase_core)         |
| [flutter_screenutil](https://pub.dev/packages/flutter_screenutil)               | [google_fonts](https://pub.dev/packages/google_fonts)           |
| [liquid_progress_indicator](https://pub.dev/packages/liquid_progress_indicator) | [provider](https://pub.dev/packages/provider)                   |

| Dev Dependencies                                                            | <!-- -->                                                          |
| --------------------------------------------------------------------------- | ----------------------------------------------------------------- |
| [change_app_package_name](https://pub.dev/packages/change_app_package_name) | [very_good_analysis](https://pub.dev/packages/very_good_analysis) |

### Build

1. Create a new [Firebase](https://firebase.google.com) project.
2. Enable email [Authentication](https://firebase.google.com/docs/auth) and [Cloud Firestore](https://firebase.google.com/docs/firestore/quickstart).
3. Connect Firebase project to [flutter](https://firebase.flutter.dev/docs/overview/).
4. On console do `flutter run`

## License

```xml
Copyright 2022 Anibal Ventura
```

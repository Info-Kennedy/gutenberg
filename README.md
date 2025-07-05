# Gutenberg Flutter App

A cross-platform (mobile & desktop) Flutter application for browsing and reading books by category, inspired by Project Gutenberg. The app features responsive layouts, search, infinite scrolling, theming, and more.

---

## Features

- **Category Browsing:** Browse books by categories such as Fiction, Drama, Humour, Politics, Philosophy, History, and Adventure.
- **Book Listing:** View books in a responsive grid with cover images, titles, and authors.
- **Search:** Search for books within a category with a modern, animated search bar.
- **Infinite Scrolling:** Load more books as you scroll.
- **Book Details:** Tap a book to open it in the browser (HTML, TXT, or fallback), or show an error if no viewable version is available.
- **Responsive UI:** Adapts to mobile, tablet, and desktop layouts using `responsive_framework`.
- **Theming:** Light, dark, and system theme support.
- **State Management:** Uses `flutter_bloc` for robust state management.
- **Network Caching:** Book cover images are cached for performance.
- **Localization Ready:** Language helper for future localization.

---

## Project Structure

```
lib/
  app/                # App entry, routing, and theme
  books/              # Book feature: views, models, bloc, repository
  categories/         # Category feature: views, bloc, repository
  common/             # Shared widgets, utils, helpers, repositories, bloc
  main.dart           # App entrypoint
```

### Key Files

- **main.dart:** App entrypoint, sets up dependency injection and theme.
- **app/app.dart:** Top-level app widget, theme, and router configuration.
- **app/routes.dart:** GoRouter setup for navigation.
- **books/views/books_mobile.dart:** Mobile book list UI with search and infinite scroll.
- **books/views/widgets/book_card_item.dart:** Book card with image, title, author, and tap-to-launch logic.
- **categories/views/categories_mobile.dart:** Mobile category list UI.

---

## Getting Started

### Prerequisites

- Flutter 3.x
- Dart 3.x

### Install Dependencies

```bash
flutter pub get
```

### Run the App

```bash
flutter run
```

### Build for Web

```bash
flutter build web
```

---

## APK Installation (Android)

You can install the prebuilt APK directly on your Android device:

1. Download the APK file: [`gutenberg-v1.apk`](./gutenberg-v1.apk)
2. Transfer the APK to your Android device (via USB, email, or cloud storage).
3. On your device, open the APK file. You may need to allow installation from unknown sources.
4. Follow the prompts to install the app.
5. Launch "Gutenberg" from your app drawer!

---

## Configuration

- **API Base URL:** Set in `lib/common/utils/constants.dart` (`Constants.API_BASE_URL`).
- **Assets:** SVG icons and images are in `assets/icons/` and `assets/images/`.
- **Themes:** Configured in `lib/common/utils/theme_config.dart` and managed by `ThemeCubit`.

---

## Key Packages Used

- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [go_router](https://pub.dev/packages/go_router)
- [responsive_framework](https://pub.dev/packages/responsive_framework)
- [cached_network_image](https://pub.dev/packages/cached_network_image)
- [dio](https://pub.dev/packages/dio)
- [logger](https://pub.dev/packages/logger)
- [flutter_svg](https://pub.dev/packages/flutter_svg)
- [flutter_form_builder](https://pub.dev/packages/flutter_form_builder) (for advanced forms, but not required for the search bar)

---

## How It Works

- **Categories:** Fetched from a local list in `CategoriesRepository`.
- **Books:** Fetched from a remote API using `BooksRepository` and `ApiRepository`.
- **Search:** Updates the book list as you type (after 7 characters).
- **Book Tap:** Opens the book in the browser (HTML > TXT), or shows an error dialog if not available.
- **State Management:** All business logic is handled by Blocs (`BooksBloc`, `CategoriesBloc`).
- **Theming:** User can toggle between light, dark, and system themes.

---

## Customization

- **Add Categories:** Edit the list in `CategoriesRepository`.
- **Change API Endpoint:** Update `Constants.API_BASE_URL`.
- **Add More Book Formats:** Extend the `Formats` model and update the tap logic in `BookCardItem`.

---

## Contributing

1. Fork the repo
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Create a new Pull Request

---

## License

MIT

---

**Happy reading!**

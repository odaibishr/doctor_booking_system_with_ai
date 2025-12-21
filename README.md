# Doctor Booking System with AI

A comprehensive Flutter-based mobile application for booking medical appointments with integrated AI chat assistance. This system provides a seamless experience for patients to find doctors, book appointments, and manage their healthcare journey.

## Features

### Authentication & User Management

- Secure user authentication system
- Profile creation and management
- Password recovery functionality

### Core Functionality

- **Doctor Discovery**: Browse and search for doctors by specialty
- **Hospital Management**: View and explore healthcare facilities
- **Smart Search**: Advanced search functionality for finding the right healthcare provider
- **Appointment Booking**: Schedule appointments with preferred doctors
- **Booking History**: Track past and upcoming appointments
- **Favorites**: Save preferred doctors for quick access

### AI-Powered Features

- Integrated AI chat assistant for healthcare queries
- Intelligent doctor recommendations

### User Experience

- Beautiful onboarding experience
- Real-time notifications
- Payment integration
- Multi-language support (Arabic & English)
- Responsive and intuitive UI

## Technology Stack

### Framework & Language

- **Flutter** (SDK ^3.9.0)
- **Dart**

### State Management & Architecture

- **BLoC Pattern** (`flutter_bloc`, `bloc`)
- **Clean Architecture** with feature-based organization
- **Dependency Injection** using `get_it`

### Key Dependencies

- **Navigation**: `go_router` for declarative routing
- **Networking**: `dio` for HTTP requests
- **Local Storage**: `hive_flutter`
- **Caching**: `cached_network_image`, `flutter_cache_manager`
- **UI Components**:
  - `carousel_slider` for image carousels
  - `table_calendar` for date selection
  - `easy_date_timeline` for timeline views
  - `loading_animation_widget` for loading states
  - `toastification` for notifications
- **Functional Programming**: `dartz` for error handling
- **Environment Configuration**: `flutter_dotenv`
- **Connectivity**: `data_connection_checker_tv`

## Project Structure

```
lib/
├── core/                    # Core functionality and shared resources
│   ├── auth/               # Authentication utilities
│   ├── database/           # Local database management
│   ├── errors/             # Error handling
│   ├── layers/             # Clean architecture layers
│   ├── manager/            # Global state management
│   ├── network/            # Network utilities
│   ├── notifications/      # Push notifications
│   ├── storage/            # Storage utilities
│   ├── styles/             # App theming and styles
│   ├── usecases/           # Business logic use cases
│   ├── utils/              # Helper utilities
│   └── widgets/            # Reusable widgets
│
├── features/               # Feature modules
│   ├── ai_chat/           # AI chat assistant
│   ├── appointment/       # Appointment management
│   ├── auth/              # Authentication
│   ├── booking_history/   # Booking history
│   ├── categories/        # Medical categories
│   ├── create_profile/    # User profile creation
│   ├── favorite_doctor/   # Favorite doctors
│   ├── forget_password/   # Password recovery
│   ├── home/              # Home screen
│   ├── hospital/          # Hospital management
│   ├── notification/      # Notifications
│   ├── onboarding/        # Onboarding screens
│   ├── payment/           # Payment processing
│   ├── profile/           # User profile
│   ├── search/            # Search functionality
│   └── splash/            # Splash screen
│
├── main.dart              # Application entry point
└── service_locator.dart   # Dependency injection setup
```

## Getting Started

### Prerequisites

- Flutter SDK (^3.9.0)
- Dart SDK
- Android Studio / VS Code
- Android SDK / Xcode (for iOS)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/odaibishr/doctor_booking_system_with_ai.git
   cd doctor_booking_system_with_ai
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Environment Configuration**

   Create a `.env` file in the root directory:

   ```env
   API_BASE_URL=your_api_url_here
   ```

4. **Generate Hive adapters** (if needed)

   ```bash
   flutter packages pub run build_runner build
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

## Design Features

- Custom Arabic font (JF-Flat) for enhanced Arabic language support
- Material Design principles
- Smooth animations and transitions
- Responsive layouts for different screen sizes
- SVG icon support with caching
- Optimized image loading with caching

## Localization

The app supports multiple languages:

- Arabic (ar) - Default
- English (en)

## Build & Release

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

## License

This project is private and not published to pub.dev.

## Author

**Odai Bishr**

- GitHub: [@odaibishr](https://github.com/odaibishr)

---

**Note**: This application requires a backend API to function properly. Make sure to configure the API endpoint in the `.env` file before running the application.

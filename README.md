# Visits Tracker - Route-to-Market Sales Force Automation

A Flutter application for managing sales visits, built with clean architecture principles, Riverpod as State Management and dependency injection for scalability and maintainability.

## 🎯 Overview

Visits Tracker is a sample Sales Force Automation (SFA) app designed for route-to-market operations. It enables sales representatives to efficiently manage customer visits, track activities, and analyze performance metrics. The app provides a seamless experience for creating, viewing, and filtering visits. 
<!-- while maintaining offline capabilities and real-time synchronization. -->

## 📱 Screenshots

- Visits List Page with search and filter functionality
- Add Visit Form with customer selection and activity tracking
- Visit Statistics Dashboard with completion rates
- Individual Visit Cards showing customer details and status

## 🏗️ Key Architectural Choices

### Clean Architecture Implementation
- **Domain Layer**: Contains business entities, repositories interfaces, and use cases
- **Data Layer**: Implements repositories, data sources, and models with JSON serialization
- **Presentation Layer**: Manages UI components, state management, and user interactions

**Why Clean Architecture?**
- Separation of concerns ensures maintainable and testable code
- Business logic is independent of UI and external dependencies
- Easy to swap implementations (e.g., different APIs or local storage)
- Facilitates team collaboration and code reviews

### State Management - Riverpod
- **Provider-based architecture** for dependency injection and state management
- **AsyncValue** handling for loading, error, and success states
- **StateNotifier** for complex state mutations
- **FutureProvider** for asynchronous data fetching

**Why Riverpod?**
- Compile-safe dependency injection
- Better testing capabilities compared to Provider
- Automatic disposal of resources
- Strong typing and excellent developer experience

### Repository Pattern
- Abstract interfaces in domain layer
- Concrete implementations in data layer
- Single source of truth for data operations
- Easy mocking for unit tests
<!-- 
**Why Repository Pattern?**
- Decouples business logic from data sources
- Enables easy testing with mock implementations
- Allows switching between different data sources
- Centralizes data access logic -->

### Navigation - GoRouter
- Declarative routing with type safety
- Deep linking support
- Nested navigation capabilities
- Integration with Riverpod for route-aware state management

## 🚀 Setup Instructions

### Prerequisites
- Flutter SDK 3.16.x or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions
- Git for version control

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <your-repository-url>
   cd visit_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (JSON serialization & Riverpod)**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Configure API Endpoint**
   - Update `lib/core/constants/api_constants.dart` with your Supabase URL and API key
   - Ensure your Supabase database has the required tables (customers, activities, visits)

5. **Run the application**
   ```bash
   flutter run
   ```
   for running on chrome 
   ````python
   flutter run -d chrome
   ````



## 🧪 Testing Strategy

### Test Structure
- **Unit Tests**: Domain layer use cases and business logic
- **Widget Tests**: Individual UI components and forms
- **Integration Tests**: End-to-end user flows
- **Mock Implementations**: Repository and data source mocking

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/features/visits/domain/usecases/get_visits_test.dart
```

### Test Coverage Areas
- ✅ Use case business logic
- ✅ Repository implementations
- ✅ Form validation logic
- ✅ State management providers
- ✅ Widget rendering and interactions

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow
- **Continuous Integration**: Automated testing on every push/PR
- **Code Quality**: Flutter analyze and linting
- **Build Artifacts**: APK generation for releases
- **Multi-platform**: Support for Android and iOS builds

### Pipeline Features
- Automated dependency installation
- Code generation execution
- Test suite execution
- Static analysis and linting
- Release artifact creation

<!-- ## 📊 Features Implemented

### Core Functionality
- ✅ **Visit Management**: Create, view, update, and delete visits
- ✅ **Customer Integration**: Link visits to customers from database
- ✅ **Activity Tracking**: Associate multiple activities with each visit
- ✅ **Status Management**: Track visit status (Pending, Completed, Cancelled)
- ✅ **Search & Filter**: Real-time search and status-based filtering
- ✅ **Statistics Dashboard**: Visit completion rates and performance metrics

### Technical Features
- ✅ **Real-time Data Sync**: Integration with Supabase REST API
- ✅ **Form Validation**: Comprehensive input validation and error handling
- ✅ **Loading States**: Proper loading indicators and error states
- ✅ **Responsive Design**: Adaptive UI for different screen sizes
- ✅ **Date/Time Handling**: Proper timezone and formatting support
- ✅ **Error Recovery**: Retry mechanisms and graceful error handling -->

<!-- ## 🔌 Offline Support

### Current Implementation
- **Cache Strategy**: In-memory caching of fetched data
- **State Persistence**: Riverpod maintains state during app lifecycle
- **Error Handling**: Graceful degradation when network is unavailable

### Future Enhancements
- Local database integration (SQLite/Hive)
- Background synchronization
- Conflict resolution for offline changes
- Offline-first architecture with sync queues -->

## 🎯 Assumptions & Trade-offs

### Assumptions Made
1. **Network Connectivity**: Primary assumption of internet availability for core functionality
2. **Data Volume**: Moderate visit volume (hundreds, not thousands per user)
3. **Single User**: App designed for individual sales representative use
4. **Supabase Backend**: Assumption of specific backend service structure
5. **Mobile and web intergration**: Primary focus on mobile platforms (Android/iOS) and web.

### Trade-offs Implemented
1. **Simplicity vs Features**: Prioritized core functionality over advanced features
2. **Performance vs Flexibility**: Used clean architecture despite slight performance overhead
3. **Development Speed vs Optimization**: Focused on maintainable code over micro-optimizations
4. **Bundle Size vs Convenience**: Included comprehensive UI libraries for better UX

### Known Limitations
1. **Offline Functionality**: Limited offline capabilities in current version
2. **Real-time Updates**: No WebSocket implementation for live data updates
3. **File Attachments**: No support for attaching photos or documents to visits
4. **Advanced Analytics**: Basic statistics only, no advanced reporting
5. **Multi-user Collaboration**: No real-time collaboration features
6. **Bulk Operations**: No batch operations for multiple visits

## 🔮 Future Enhancements

### Short-term Roadmap
- [ ] Offline data persistence with SQLite
- [ ] Photo attachments for visits
- [ ] Push notifications for visit reminders
- [ ] Export functionality (PDF/Excel reports)
- [ ] Advanced filtering options

### Long-term Vision
- [ ] Real-time collaboration features
- [ ] Advanced analytics and reporting
- [ ] Integration with CRM systems
- [ ] Machine learning for route optimization
- [ ] Multi-language support

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email [pnjogubless@gmail.com] or create an issue in the GitHub repository.

---

**Built using Flutter and Clean Architecture principles**
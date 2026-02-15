# 📐 Khadamaty App - Coding Guidelines

> **CRITICAL**: Follow these guidelines for ALL code changes!

---

## 🎯 Responsive System - MUST USE

### ❌ NEVER Do This:

```dart
// ❌ Manual screen width checks
final width = MediaQuery.of(context).size.width;
if (width > 600) { ... }

// ❌ Hardcoded breakpoints
if (screenWidth > 1280) { ... }

// ❌ Hardcoded spacing
padding: EdgeInsets.all(16)
margin: EdgeInsets.only(bottom: 24)
```

### ✅ ALWAYS Do This:

```dart
// ✅ Use context extensions
if (context.isDesktop) { ... }
if (context.isTablet) { ... }
if (context.isMobile) { ... }

// ✅ Use AppSpacing
padding: EdgeInsets.all(AppSpacing.page(context))  // 16→24→32
margin: EdgeInsets.only(bottom: AppSpacing.md(context))  // 16→20→24

// ✅ Use responsive values for custom sizes
final size = context.responsive(
  mobile: 100.0,
  tablet: 120.0,
  desktop: 150.0,
)
```

---

## 📏 Spacing System

### Available AppSpacing Methods:

- `AppSpacing.xs(context)` → 4-6-8px
- `AppSpacing.sm(context)` → 8-10-12px
- `AppSpacing.md(context)` → 16-20-24px (most common)
- `AppSpacing.lg(context)` → 24-28-32px
- `AppSpacing.xl(context)` → 32-40-48px
- `AppSpacing.page(context)` → 16-24-32px (page padding)
- `AppSpacing.card(context)` → 12-14-16px (grid spacing)

### ✅ Always Import:

```dart
import 'package:khadamaty_app/core/utils/app_spacing.dart';
import 'package:khadamaty_app/core/utils/responsive_value.dart';
```

---

## 🎨 Theme System

### ❌ NEVER Do This:

```dart
// ❌ Direct color access
color: Colors.blue
color: isDark ? Colors.white : Colors.black

// ❌ Override theme text colors
style: Theme.of(context).textTheme.bodySmall?.copyWith(
  color: AppColors.textSecondary(context), // ❌ Already in theme!
)
```

### ✅ ALWAYS Do This:

```dart
// ✅ Use AppColors methods for containers, borders, backgrounds
color: AppColors.primaryBlue
color: AppColors.surface(context)
color: AppColors.background(context)

// ✅ Use theme textStyles WITHOUT color override
style: Theme.of(context).textTheme.bodySmall  // Already has correct color!
style: Theme.of(context).textTheme.titleMedium

// ✅ Use AppColors for Icons (no theme for icons)
Icon(
  Icons.person,
  color: AppColors.textSecondary(context),
)

// ✅ Override color ONLY when needed (e.g., primary color for price)
style: Theme.of(context).textTheme.titleMedium?.copyWith(
  color: AppColors.primaryBlue,  // OK - special case
)
```

### 📝 Theme Text Colors Reference:

- `bodySmall` → Already uses `textSecondaryColor`
- `labelSmall` → Already uses `textSecondaryColor`
- All other text styles → Use `textPrimaryColor`

**Rule**: Don't override text color unless you have a specific reason!

---

## 📂 Project Structure

### Feature Structure:

```
features/
  feature_name/
    presentation/
      pages/          # Full screens
      widgets/        # Reusable feature widgets
      cubits/         # State management
        cubit_name/
          cubit.dart
          state.dart
          mock_data.dart (if needed)
```

### Core Structure:

```
core/
  theme/           # AppColors, AppTheme
  utils/           # Responsive, Spacing, Validators
  widgets/         # Reusable app-wide widgets
  di/              # Dependency injection container
```

---

## 🏗️ Clean Architecture Rules

> **CRITICAL**: Every feature MUST follow this layer structure!

### Feature Folder Structure:

```
features/
  feature_name/
    domain/                 # Business Logic Layer
      entities/             # Pure Dart classes
        feature_entity.dart
      repositories/         # Abstract contracts
        feature_repository.dart
      usecases/             # Single-purpose actions
        create_feature_usecase.dart

    data/                   # Data Layer
      datasources/          # Remote/Local data sources
        feature_remote_data_source.dart
      models/               # Firebase/API models
        feature_model.dart
      repositories/         # Implementation
        firebase_feature_repository.dart

    presentation/           # UI Layer
      pages/                # Full screens
        feature_screen.dart
      widgets/              # Feature widgets
        feature_widgets/    # Nested folder for widgets
          feature_card.dart
          feature_list_item.dart
      cubits/               # State management
        feature_cubit/
          feature_cubit.dart
          feature_state.dart
```

### Domain Layer Rules:

#### ✅ Entities (domain/entities/)

```dart
// ✅ YES! Extend Equatable, add copyWith
class BookingEntity extends Equatable {
  final String id;
  final String name;
  // ...

  const BookingEntity({required this.id, required this.name});

  @override
  List<Object?> get props => [id, name];

  BookingEntity copyWith({String? id, String? name}) {
    return BookingEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
```

#### ✅ Repositories (domain/repositories/)

```dart
// ✅ YES! Abstract class with Dartz Either
import 'package:dartz/dartz.dart';

abstract class BookingRepository {
  Future<Either<Failure, void>> createBooking(BookingEntity booking);
  Future<Either<Failure, List<BookingEntity>>> getUserBookings(String userId);
}
```

#### ✅ Use Cases (domain/usecases/)

```dart
// ✅ YES! Single purpose, named constructor params
class CreateBookingUseCase {
  final BookingRepository _repository;

  CreateBookingUseCase({required BookingRepository repository})
      : _repository = repository;

  Future<Either<Failure, void>> call(BookingEntity booking) async {
    return await _repository.createBooking(booking);
  }
}
```

### Data Layer Rules:

#### ✅ Models (data/models/)

```dart
// ✅ YES! Extend Entity, add factory methods
class BookingModel extends BookingEntity {
  const BookingModel({required super.id, required super.name});

  // From external source
  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookingModel(
      id: doc.id,
      name: data['name'] ?? '',
    );
  }

  // From entity (for writes)
  factory BookingModel.fromEntity(BookingEntity entity) {
    return BookingModel(id: entity.id, name: entity.name);
  }

  // To external source
  Map<String, dynamic> toFirestore() {
    return {'name': name};
  }
}
```

#### ✅ Repository Implementation (data/repositories/)

```dart
// ✅ YES! Implement abstract, wrap in try-catch, return Either
class FirebaseBookingRepositoryImp implements BookingRepository {
  final BookingRemoteDataSource _remoteDataSource;

  FirebaseBookingRepositoryImp({required BookingRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, void>> createBooking(BookingEntity booking) async {
    try {
      await _remoteDataSource.createBooking(booking);
      return const Right(null);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message, code: e.code));
    } catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
```

### Presentation Layer Rules:

#### ✅ Widgets Location

```dart
// ✅ YES! Widgets in nested feature_widgets/ folder
// features/bookings/presentation/widgets/bookings_widgets/booking_card.dart

class BookingCard extends StatelessWidget {
  final BookingEntity booking;
  const BookingCard({super.key, required this.booking});
  // ...
}
```

### Dependency Injection (core/di/injection_container.dart):

```dart
// Register in this order:
// 1. Data Sources
sl.registerLazySingleton<BookingRemoteDataSource>(
  () => BookingRemoteDataSourceImpl(firestore: sl()),
);

// 2. Repositories
sl.registerLazySingleton<BookingRepository>(
  () => FirebaseBookingRepositoryImp(remoteDataSource: sl()),
);

// 3. Use Cases
sl.registerLazySingleton(() => CreateBookingUseCase(repository: sl()));

// 4. Cubits (use registerFactory, not registerLazySingleton!)
sl.registerFactory(() => BookingsCubit(
  getUserBookingsUseCase: sl(),
  authRepository: sl(),
));
```

---

## 📛 Naming Conventions

### ❌ NEVER Do This:

```dart
// ❌ NO! Don't use "I" prefix for interfaces
abstract class IServiceRepository { }
abstract class IAuthRepository { }

// ❌ NO! Hungarian notation
String strName;
int iCount;
```

### ✅ ALWAYS Do This:

```dart
// ✅ YES! Use descriptive names without prefixes
abstract class ServiceRepository { }
abstract class AuthRepository { }

// ✅ For implementations, use descriptive suffix
class FirebaseServiceRepository implements ServiceRepository { }
class SupabaseServiceRepository implements ServiceRepository { }

// ✅ Clear variable names
String userName;
int itemCount;
```

---

## 🔄 State Management Rules

### Use BlocProvider + BlocConsumer:

```dart
BlocProvider(
  create: (context) => MyCubit()..loadData(context),
  child: BlocConsumer<MyCubit, MyState>(
    listener: (context, state) {
      // Handle side effects (errors, navigation)
    },
    builder: (context, state) {
      // Build UI based on state
    },
  ),
)
```

### Pass BuildContext to Cubit Methods:

```dart
// ✅ For localization and responsive values
void loadData(BuildContext context) {
  final data = MockData.getData(context);
  // ...
}
```

---

## 🧩 Widget Extraction

### ❌ NEVER Extract as Method:

```dart
// ❌ NO! Widget as method
Widget _buildSomeWidget(BuildContext context) {
  return Container(...);
}
```

### ✅ ALWAYS Extract as StatelessWidget:

```dart
// ✅ YES! Widget as StatelessWidget
class SomeWidget extends StatelessWidget {
  final String data;

  const SomeWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(...);
  }
}
```

**Why?**

- ✅ Better performance (Flutter can optimize rebuilds)
- ✅ Reusable across files
- ✅ Cleaner code organization
- ✅ Easier to test
- ✅ Can use `const` constructors

**Where to put widgets?**

- Feature-specific widgets → `features/feature_name/presentation/feature_widgets/`
- Reusable app-wide widgets → `core/widgets/`

---

## 🔄 Reusable Components & Utilities

### ✅ Use UIHelpers Instead of Direct Calls

**❌ DON'T Repeat:**

```dart
// ❌ NO! Repeating dialog code everywhere
showDialog(
  context: context,
  builder: (dialogContext) => AlertDialog(
    title: Text('Delete?'),
    content: Text('Are you sure?'),
    actions: [
      TextButton(...),
      ElevatedButton(...),
    ],
  ),
);

// ❌ NO! Repeating snackbar code
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Success!'),
    backgroundColor: Colors.green,
  ),
);
```

**✅ DO Use UIHelpers:**

```dart
// ✅ YES! Use UIHelpers utility
import 'package:khadamaty_app/core/utils/ui_helpers.dart';

// Confirmation Dialog
final confirmed = await UIHelpers.showConfirmDialog(
  context: context,
  title: 'Delete Service',
  message: 'Are you sure?',
  confirmText: 'Delete',
  isDangerous: true,
);

// Success Snackbar
UIHelpers.showSuccessSnackbar(
  context: context,
  message: 'Service deleted successfully',
);

// Error Snackbar
UIHelpers.showErrorSnackbar(
  context: context,
  message: 'Failed to delete service',
);

// Info Snackbar
UIHelpers.showInfoSnackbar(
  context: context,
  message: 'Feature coming soon',
);

// Delete with Confirmation (all-in-one)
await UIHelpers.deleteWithConfirmation(
  context: context,
  title: 'Delete Service',
  message: 'Are you sure you want to delete this service?',
  itemName: service.title,
  confirmText: 'Delete',
  cancelText: 'Cancel',
  onDelete: () => cubit.deleteService(service.id),
);
```

**Benefits:**

- ✅ Consistent UI across the app
- ✅ Less code duplication
- ✅ Easy to change styling in one place
- ✅ Type-safe parameters
- ✅ Built-in best practices

**Available Utilities:**

- `UIHelpers.showConfirmDialog()` - Yes/No dialogs
- `UIHelpers.showSuccessSnackbar()` - Green success messages
- `UIHelpers.showErrorSnackbar()` - Red error messages
- `UIHelpers.showInfoSnackbar()` - Default info messages
- `UIHelpers.deleteWithConfirmation()` - Complete delete flow with confirmation + success/error handling

---

## 🌍 Localization

### ✅ Always Use:

```dart
S.of(context).keyName  // Generated from .arb files
```

### ❌ NEVER Hardcode Strings:

```dart
// ❌ NO! Hardcoded strings
Text('Hello')
LoadingIndicator(message: 'Loading...')
ErrorDisplay(message: 'Failed to load')
SnackBar(content: Text('Success!'))
```

### ✅ Use Localization:

```dart
// ✅ YES! Localized strings
Text(S.of(context).hello)
LoadingIndicator(message: S.of(context).loading)
ErrorDisplay(message: S.of(context).loadError)
SnackBar(content: Text(S.of(context).success))
```

**Steps to add new localized string:**

1. Add key to `lib/l10n/intl_en.arb`
2. Add key to `lib/l10n/intl_ar.arb`
3. Run: `flutter pub run intl_utils:generate`
4. Use: `S.of(context).keyName`

**Rule**: EVERY user-facing string MUST be localized!

---

## 📝 Before Writing ANY Code:

1. **Review existing similar pages** (explore_page, home_screen, etc.)
2. **Check `core/utils`** for existing utilities
3. **Check `core/widgets`** for reusable widgets
4. **Use project patterns**, don't reinvent the wheel!

---

## 🚨 Code Review Checklist

Before submitting ANY code, verify:

- [ ] Uses `context.isDesktop/isTablet/isMobile` (not manual checks)
- [ ] Uses `AppSpacing.xxx(context)` (not hardcoded values)
- [ ] Uses `AppColors.xxx(context)` (not direct colors)
- [ ] Uses `S.of(context).xxx` (not hardcoded strings)
- [ ] Imports responsive_value and app_spacing
- [ ] Follows existing project structure
- [ ] Consistent with similar pages

---

## 📚 Key Files to Review First

Before any responsive work:

1. `lib/core/utils/responsive_value.dart`
2. `lib/core/utils/app_spacing.dart`
3. `lib/core/theme/app_colors.dart`
4. Similar existing pages

---

## 💡 Philosophy

**"Don't create new patterns when existing ones work!"**

This project has a well-designed responsive system. USE IT! 🎯

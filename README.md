# 🔧 Khadamaty - خدماتي

> **Local Services Marketplace Platform** - Connecting customers with service providers in Egypt

[![Flutter](https://img.shields.io/badge/Flutter-3.2+-blue?logo=flutter)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore-orange?logo=firebase)](https://firebase.google.com)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-green)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![Status](https://img.shields.io/badge/Status-In%20Development-yellow)]()

---

## 📱 Overview

**Khadamaty** is a mobile marketplace connecting customers with local service providers. The platform supports both **on-demand services** (plumbing, electrical) and **appointment-based services** (doctors, salons).

### Target Market
- 📍 Asyut Governorate, Egypt (Deirout Center)
- 🏠 Home services, Car repair, Medical, Beauty, Education

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────┐
│                  Presentation                    │
│         (Pages, Widgets, Cubits/States)         │
├─────────────────────────────────────────────────┤
│                    Domain                        │
│         (Entities, Repositories, UseCases)       │
├─────────────────────────────────────────────────┤
│                     Data                         │
│      (Models, Firebase Repositories, APIs)       │
└─────────────────────────────────────────────────┘
```

**Key Patterns:**
- 🎯 **Clean Architecture** - Separation of concerns
- 🔄 **Repository Pattern** - Abstracted data sources
- 💉 **Dependency Injection** - GetIt service locator
- 📦 **BLoC/Cubit** - State management

---

## ✨ Features

### ✅ Implemented
- 🔐 **Authentication** - Email registration, login, password reset
- ➕ **Add Service** - Create services with category, price, location
- 📋 **My Services** - View, edit, delete provider services
- 🔥 **Real-time Updates** - Firestore live synchronization
- 🌍 **Localization** - Arabic & English (RTL support)
- 📱 **Responsive Design** - Mobile, Tablet, Desktop layouts

### 🔜 In Progress
- 📅 **Booking System** - On-demand & appointment booking
- 🔍 **Explore Services** - Browse and search all services
- 🖼️ **Image Upload** - Service photos
- ⭐ **Reviews & Ratings**

---

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| **UI** | Flutter 3.2+ |
| **State** | flutter_bloc / Cubit |
| **Backend** | Firebase (Auth, Firestore) |
| **DI** | GetIt |
| **Navigation** | go_router |
| **Error Handling** | dartz (Either/Functional) |

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── di/                 # Dependency Injection
│   ├── error/              # Failure classes
│   ├── theme/              # Colors, Themes
│   ├── utils/              # Spacing, Validators
│   └── widgets/            # Reusable widgets
│
├── features/
│   ├── auth/               # Authentication
│   │   ├── data/           # Firebase implementation
│   │   ├── domain/         # Entities, Repository interfaces
│   │   └── presentation/   # Pages, Cubits
│   │
│   ├── provider/           # Service Provider features
│   │   ├── data/           # FirebaseServiceRepository
│   │   ├── domain/         # ServiceEntity, UseCases
│   │   └── presentation/   # AddService, MyServices
│   │
│   ├── home/               # Home & Explore
│   └── bookings/           # Booking management
│
└── l10n/                   # Localization (AR/EN)
```

---

## 🚀 Getting Started

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/khadamaty_app.git

# Install dependencies
flutter pub get

# Configure Firebase
flutterfire configure

# Run the app
flutter run
```

---

## 📸 Screenshots

> *Coming soon*

---

## 👨‍💻 Developer

**Abdelrahman Maged**

---

## 📄 License

This project is proprietary and in active development.

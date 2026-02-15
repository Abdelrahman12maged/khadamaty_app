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

<img width="704" height="1472" alt="Gemini_Generated_Image_dnatsqdnatsqdnat" src="https://github.com/user-attachments/assets/eaa94b93-ffcf-4e4a-a525-5b246a873921" />
![6](https://github.com/user-attachments/assets/6f96001a-b95a-4024-832e-0b2c2e3d83a3)
![5](https://github.com/user-attachments/assets/5f33c8ab-2d7f-4b5e-bd63-1e742a9aa1de)
![4](https://github.com/user-attachments/assets/f8ba8a42-6f3c-435c-bf26-d0f2ebc35aa3)
![3](https://github.com/user-attachments/assets/7b3b2241-0a15-4a30-9d3a-9e0d267ecf3c)
![2](https://github.com/user-attachments/assets/e5f77515-9b67-4b42-9c54-4b095042bf19)
![1](https://github.com/user-attachments/assets/c98555de-4165-48d1-8729-31de92d48c23)
![10](https://github.com/user-attachments/assets/096ab5b7-494b-4191-a927-c7e43dc871af)
![9](https://github.com/user-attachments/assets/481a87be-06ba-4f21-94fd-71b41f4d33a3)
![8](https://github.com/user-attachments/assets/64173ad4-28b9-4d2b-8b8a-eb83e427065d)
![7](https://github.com/user-attachments/assets/13a3b7b1-58f7-4d14-b41a-a618c936b442)


---

## 👨‍💻 Developer

**Abdelrahman Maged**

---

## 📄 License

This project is proprietary and in active development.

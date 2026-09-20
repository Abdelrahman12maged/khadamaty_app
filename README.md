<div align="center">

# 🔧 Khadamaty — خدماتي

**Local Services Marketplace Platform** — connecting customers with trusted service providers in Egypt

[![Flutter](https://img.shields.io/badge/Flutter-3.2+-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore%20%7C%20Storage-FFCA28?style=flat&logo=firebase&logoColor=black)](https://firebase.google.com)
[![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=flat&logo=supabase&logoColor=white)](https://supabase.com)
[![Stripe](https://img.shields.io/badge/Stripe-Payments-635BFF?style=flat&logo=stripe&logoColor=white)](https://stripe.com)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-4CAF50?style=flat)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
[![Status](https://img.shields.io/badge/Status-Active%20Development-yellow)]()

</div>

---

## 🎬 Video Demo

<div align="center">

[![Watch the demo](https://img.youtube.com/vi/x2vV20UIjq4/hqdefault.jpg)](https://youtu.be/x2vV20UIjq4)

**▶ Click the thumbnail above to watch the full demo on YouTube**

</div>

---

## 📱 Overview

**Khadamaty** is a mobile marketplace connecting customers with local service providers, supporting both **on-demand services** (plumbing, electrical, car repair) and **appointment-based services** (doctors, salons, education).

| | |
|---|---|
| 📍 **Target Market** | Asyut Governorate, Egypt (Deirout Center) |
| 🏠 **Categories** | Home Services · Car Repair · Medical · Beauty · Education |
| 💳 **Payments** | Stripe (EGP) |
| 🌐 **Languages** | Arabic & English (full RTL support) |

---

## ✨ What It Does

- 🔐 **Full Authentication Flow** — Register, Login, Email Verification
- 🔍 **Browse, Search & Filter** services by category and location
- 📅 **Complete Booking Lifecycle** — Pending → Confirmed → Paid → Completed
- 🧑‍🔧 **Provider Dashboard** — Accept / Decline bookings in real time
- 💳 **Stripe Payment Integration** (EGP)
- 💬 **Real-Time Chat** between customers and providers
- 🗺️ **Interactive Map** for service location (OpenStreetMap)
- 🌐 **Arabic & English** with instant language switching
- 🌙 **Dark Mode**
- 📱 **Responsive Design** — Mobile, Tablet, and Desktop layouts

---

## 🏗️ Architecture

Clean Architecture with full separation of concerns across **8 modular features**:

```
Auth │ Bookings │ Chat │ Explore │ Home │ Onboarding │ Payment │ Provider
```

```
┌─────────────────────────────────────────────────┐
│                  Presentation                    │
│         (Pages, Widgets, Cubits/States)          │
├─────────────────────────────────────────────────┤
│                    Domain                        │
│         (Entities, Repositories, UseCases)       │
├─────────────────────────────────────────────────┤
│                     Data                         │
│      (Models, Firebase Repositories, APIs)       │
└─────────────────────────────────────────────────┘
```

**Key Patterns**

- 🎯 **Clean Architecture** — Data, Domain & Presentation layers, fully decoupled
- 🔄 **Repository Pattern** — Abstracted data sources
- 💉 **Dependency Injection** — GetIt service locator
- 📦 **BLoC / Cubit** — Predictable state management
- ⚖️ **Functional Error Handling** — `dartz` (Either)

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| **UI** | Flutter, Dart |
| **State Management** | flutter_bloc / Cubit |
| **Backend** | Firebase (Auth, Firestore, Storage), Supabase |
| **Payments** | Stripe |
| **Maps** | OpenStreetMap |
| **Dependency Injection** | GetIt |
| **Navigation** | go_router |
| **Local Storage** | Hive |
| **Networking** | Dio |
| **Error Handling** | dartz (Either / Functional) |

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── di/                 # Dependency Injection
│   ├── error/               # Failure classes
│   ├── theme/                # Colors, Themes, Dark Mode
│   ├── utils/                # Spacing, Validators
│   └── widgets/              # Reusable widgets
│
├── features/
│   ├── auth/                 # Register, Login, Email Verification
│   ├── onboarding/           # First-run experience
│   ├── home/                 # Home & category navigation
│   ├── explore/               # Browse, search & filter services
│   ├── provider/              # Add/manage services, provider dashboard
│   ├── bookings/              # Full booking lifecycle
│   ├── payment/                # Stripe integration
│   └── chat/                   # Real-time customer ↔ provider chat
│
└── l10n/                      # Localization (AR/EN)
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

<div align="center">
<img width="500" alt="Khadamaty App Preview" src="https://github.com/user-attachments/assets/eaa94b93-ffcf-4e4a-a525-5b246a873921" />
</div>

---

## 👨‍💻 Developer

**Abdelrahman Maged**

- 💻 GitHub: [@Abdelrahman12maged](https://github.com/Abdelrahman12maged)
- ✉️ Email: [abdomaged01206@gmail.com](mailto:abdomaged01206@gmail.com)

---

## 📄 License

This project is proprietary and in active development.

# Soulmate AI - Holistic Life Companion

![Soulmate AI Hero](https://images.unsplash.com/photo-1518241353330-0f7941c2d9b5?w=1200&q=80)

**Soulmate AI** is a premium, holistic life companion application built with Flutter. Designed with a calming aesthetic and smooth micro-animations, it provides a safe space for daily reflection, emotional tracking, and mindfulness. It acts as a digital confidant, helping users navigate their emotional landscape through text and voice interactions.

---

## ✨ Key Features

### 1. 📖 Daily Reflection
A structured, calming space for users to check in with their emotions daily. Includes a dynamic mood selector, guided prompts, and an AI-assisted "Soulmate's Whisper" to inspire deep thought.

### 2. 🗂️ Memory Jar
A beautiful archive of past reflections, shared moments, and gratitude notes. Automatically categorized and easily searchable, allowing users to revisit their journey and track personal growth over time.

### 3. 🎙️ Voice Active Session (Walk & Talk)
Hands-free, empathetic voice interactions. Features stunning audio visualizers, dynamic pulsating avatars, and real-time active listening indicators for a truly conversational experience.

### 4. 🌙 Nocturnal Mode
Designed specifically for late-night thoughts and sleep preparation. Includes dream logging, ambient soundscapes, and a soothing dark-mode interface to minimize blue light exposure.

### 5. 💬 Supportive Chat
An intuitive, modern chat interface where users can converse with their AI companion. Includes smart reply suggestions, contextual daily ritual nudges, and empathetic responses.

### 6. 🔒 Privacy First & Data Export
Your memories belong to you. Soulmate AI includes built-in data export functionalities (PDF, JSON, MP3, CSV) and robust privacy settings to ensure user data remains secure and portable.

---

## 🛠️ Tech Stack & Architecture

- **Framework:** Flutter (Dart)
- **State Management:** [Riverpod](https://riverpod.dev/) (Hooks Riverpod)
- **Navigation:** [GoRouter](https://pub.dev/packages/go_router) for deep linking and persistent bottom navigation (`StatefulShellRoute`).
- **Local Storage:** [Hive](https://docs.hivedb.dev/) for fast, secure, on-device data persistence.
- **UI/UX Design:** Custom tokens matching a premium, glassmorphism-inspired design system. Heavy use of `AnimationController`, `Tween`, and `BackdropFilter`.

### Folder Structure (Feature-First Architecture)
```text
app/
├── lib/
│   ├── core/                  # Core utilities, theme, router, local storage
│   ├── features/              # Feature modules
│   │   ├── auth/              # Onboarding and Authentication
│   │   ├── chat/              # Supportive Chat UI
│   │   ├── memory_jar/        # Memory Jar UI
│   │   ├── reflection/        # Daily Reflection UI
│   │   ├── settings/          # Data Export & Encryption Keys
│   │   └── voice/             # Active Voice Sessions & Settings
│   └── main.dart              # Entry point
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable release)
- Dart SDK
- Android Studio / Xcode for emulators

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/soulmate-ai.git
   cd soulmate-ai/app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🎨 Design Philosophy
Soulmate AI avoids generic designs. It leans heavily into:
- **Calibrated Color Palettes:** Soft gradients using tailored HSL tokens.
- **Perpetual Micro-motion:** Avatars, buttons, and backgrounds feature subtle, continuous breathing and pulsing animations.
- **Glassmorphism:** Navigation bars and overlays use backdrop blurring for a layered, spatial feel.
- **Modern Typography:** Clean, legible font scaling using Google Fonts.

---

## 📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

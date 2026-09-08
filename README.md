# 📚 StudyLens AI

**StudyLens AI** is an AI-powered mobile study assistant built with **Flutter** and **Google Gemini**. It helps students transform their study material into simple, structured, and interactive learning resources.

Instead of manually reading and organizing lengthy study material, students can provide their content to StudyLens AI and receive an AI-generated summary, important concepts, simple explanations, and an interactive quiz.

---

## ✨ Features

* 📝 **AI-Generated Summary**
  Converts study material into a concise and easy-to-understand summary.

* 💡 **Key Concepts**
  Identifies the most important concepts and topics from the provided material.

* 🧠 **Simple Explanation**
  Explains difficult topics in simple, student-friendly language.

* ❓ **AI-Generated Quiz**
  Generates multiple-choice questions based on the user's study material.

* 📊 **Quiz Results**
  Displays the user's score, correct answers, and quiz performance.

* 🎨 **Modern Study-Friendly UI**
  Clean and simple interface designed for students.

* ⚡ **Loading & Error Handling**
  Provides loading feedback and handles API, network, and input errors.

---

## 🔄 How It Works

```text
        Study Material
              ↓
      Flutter Application
              ↓
       Google Gemini AI
              ↓
     AI Processing & Analysis
              ↓
    ┌─────────┼─────────┐
    ↓         ↓         ↓
 Summary   Key Concepts  Explanation
    │         │         │
    └─────────┼─────────┘
              ↓
        AI-Generated Quiz
              ↓
       Interactive Quiz
              ↓
       Score & Feedback
```

---

## 🛠️ Tech Stack

| Technology            | Purpose                         |
| --------------------- | ------------------------------- |
| **Flutter**           | Mobile application development  |
| **Dart**              | Programming language            |
| **Google Gemini API** | AI-powered content generation   |
| **HTTP**              | API communication               |
| **flutter_dotenv**    | Environment variable management |
| **Material Design**   | User interface and theming      |

---

## 🏗️ Project Architecture

The application follows a simple service-based architecture:

```text
lib/
│
├── config/
│   └── api_config.dart
│
├── models/
│   ├── sudy_result.dart
│   └── quiz_question.dart
│
├── screens/
│   ├── home_screen.dart
│   ├── study_input_screen.dart
│   ├── study_result_screen.dart
│   └── quiz_screen.dart
│
├── services/
│   ├── ai_study_service.dart
│   ├── mock_ai_study_service.dart
│   └── real_ai_study_service.dart
│
├── theme/
│   └── app_theme.dart
│
├── widgets/
│   └── reusable UI components
│
└── main.dart
```

---

## 🎯 Project Goal

The main goal of **StudyLens AI** is to make studying easier, faster, and more interactive.

Students often have to deal with lengthy notes, difficult concepts, and large amounts of study material. StudyLens AI uses generative AI to transform this material into structured learning resources.

The application focuses on:

* Reducing the time required to review study material
* Simplifying difficult concepts
* Highlighting important information
* Helping students revise through quizzes
* Providing an interactive learning experience

---

## 🚀 Getting Started

Follow the steps below to run StudyLens AI on your computer.

### Prerequisites

Before running the application, make sure you have:

* **Flutter SDK** installed
* **Dart SDK**
* **Android Studio** or another Flutter-compatible IDE
* A **Google Gemini API key**
* A physical Android device or Android Emulator

You can verify Flutter installation by running:

```bash
flutter doctor
```

---

### Installation

#### 1. Clone the Repository

Open your terminal or PowerShell and run:

```bash
git clone https://github.com/hyder5050/StudyLens-AI.git
```

#### 2. Navigate to the Project

```bash
cd StudyLens-AI
```

#### 3. Install Dependencies

Run:

```bash
flutter pub get
```

#### 4. Create the Environment File

Create a file named:

```text
.env
```

Place the `.env` file in the **root directory** of the project.

Your project should look like:

```text
StudyLens-AI/
│
├── android/
├── ios/
├── lib/
├── test/
├── .env
├── pubspec.yaml
└── README.md
```

#### 5. Add Your Gemini API Key

Open the `.env` file and add:

```env
GEMINI_API_KEY=your_api_key_here
```

Replace `your_api_key_here` with your actual Google Gemini API key.

#### 6. Run the Application

Connect an Android device or start an emulator, then run:

```bash
flutter run
```

---

## 🔐 Security

**Do not upload your `.env` file or Gemini API key to GitHub.**

Make sure `.env` is included in your `.gitignore` file:

```text
.env
```

API keys should never be publicly exposed in a GitHub repository.

> **Note:** This project uses a client-side API configuration for demonstration and educational purposes. For a production application, API requests should ideally be handled through a secure backend so the API key is not exposed in the mobile application.

---

## 📱 Application Flow

The main application flow is:

```text
Home Screen
     ↓
Study Input Screen
     ↓
Enter / Paste Study Material
     ↓
Generate Study Content
     ↓
Google Gemini API
     ↓
Study Result Screen
     ↓
┌───────────────┐
│    Summary    │
│ Key Concepts  │
│ Explanation   │
│     Quiz      │
└───────────────┘
        ↓
    Quiz Screen
        ↓
   Quiz Results
```

---

## 🤖 AI Assistance Disclosure

AI tools were used during the development of StudyLens AI for:

* Coding assistance
* Debugging
* Project planning
* UI/UX ideas
* Documentation
* Problem solving
* Improving parts of the application

All AI-assisted suggestions were reviewed, tested, and integrated by the developer.

The core project idea, implementation decisions, testing, and final integration were handled by the developer.

---

## 🏆 Hackathon

This project was developed and presented as part of a **Hackathon 2026** project.

### Project Category

**Open — General Technical Invention**

### Project Focus

**AI + Education + Flutter**

StudyLens AI demonstrates how generative AI can be integrated into a mobile application to create a more interactive and personalized study experience.

---

## 📌 Project Status

**StudyLens AI is an actively developed Flutter + AI project.**

The current version includes:

* ✅ AI-powered study material generation
* ✅ AI-generated summaries
* ✅ Key concept extraction
* ✅ Simple explanations
* ✅ AI-generated MCQs
* ✅ Interactive quiz
* ✅ Quiz scoring
* ✅ Correct/wrong answer feedback
* ✅ Loading states
* ✅ Error handling
* ✅ Modern and responsive UI
* ✅ Google Gemini API integration

---

## 🔮 Future Improvements

Possible future improvements include:

* 📄 PDF and document upload
* 🎤 Voice input
* 🔊 Text-to-speech for AI explanations
* 🌐 Multi-language support
* 📚 Study history
* 👤 User accounts and profiles
* 📈 Learning progress dashboard
* 🎯 Personalized difficulty levels
* ☁️ Cloud-based study history
* 🔐 Secure backend API integration

---

## 👨‍💻 Built With

StudyLens AI was developed as a practical **Flutter + Generative AI** project to explore how modern AI technologies can be used to solve real-world educational problems.

The project combines:

**Flutter + Dart + Google Gemini + REST API Integration + Modern UI Design**

to create a simple and useful AI-powered learning assistant.

---

## 📂 Repository

GitHub Repository:

https://github.com/hyder5050/StudyLens-AI

---

## 📄 License

This project was created for **educational and hackathon purposes**.

You may explore the source code for learning and reference.

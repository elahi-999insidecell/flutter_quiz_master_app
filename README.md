# Quiz Master - Flutter Quiz App

A feature-rich Flutter quiz application built using **Provider**, **GoRouter**, **REST API integration**, and **SharedPreferences**.
The app allows users to explore quiz categories, answer multiple-choice questions, track performance statistics, and view recent quiz history with persistent local storage.

---

## Features

### Quiz Functionality

* Browse quiz categories fetched from the Open Trivia Database API
* Start quizzes from any selected category
* Answer multiple-choice questions
* Navigate through quiz questions one by one
* View final score on the result screen
* Restart the same quiz using **Play Again**

### Performance Dashboard

* **Total Attempts** tracking
* **Highest Score** tracking
* **Last Score** tracking
* **Quiz History** showing the last 10 quiz attempts
* Newest quiz history item appears first

### Persistent Local Storage

Using **SharedPreferences**, the app stores:

* Total attempts
* Highest score
* Last score
* Last 10 quiz history records
* Theme preference (light/dark mode)

### UI/UX

* Clean and modern Flutter UI
* Light / Dark mode toggle
* Category-based quiz selection
* Progress indicator for quiz completion
* Statistics dashboard on home screen

---

## Tech Stack

* **Flutter**
* **Dart**
* **Provider** for state management
* **GoRouter** for navigation
* **Dio / API service layer** for API calls
* **SharedPreferences** for local persistence

---

## API Used

This project uses the **Open Trivia Database API**:

* Categories API:
  `https://opentdb.com/api_category.php`

* Questions API:
  `https://opentdb.com/api.php?category={id}&amount=5`

---

## Project Structure

```bash
lib/
│
├── api/
│   ├── api_services.dart
│   └── endpoints.dart
│
├── models/
│   ├── categorymodel.dart
│   └── cqmodel.dart
│
├── providers/
│   ├── quizprovider.dart
│   └── thema.dart
│
├── screens/
│   ├── home.dart
│   ├── question.dart
│   └── result.dart
│
├── utils/
│   ├── sharedpref.dart
│   ├── category_icon.dart
│   └── categorycard.dart
│
├── widgets/
│   └── stats.dart
│
└── main.dart
```

---

## State Management

The app uses **Provider** for:

* fetching categories and questions
* storing selected quiz answers
* calculating score
* resetting quiz state
* theme toggling

---

## Local Storage Logic

The app uses **SharedPreferences** to persist:

### Stored Metrics

* `totalAttempts`
* `highestScore`
* `lastScore`

### Quiz History

The last **10 quiz results** are stored in a list format such as:

```text
Science: Computers : 4/5
Entertainment: Film : 3/5
Sports : 5/5
```

The most recently played quiz appears at the top of the history list.

---

## How the App Works

1. App launches and fetches quiz categories from the API
2. User selects a category
3. The app loads 5 questions for that category
4. User answers each question
5. On quiz completion:

   * score is calculated
   * total attempts are updated
   * highest score is updated if needed
   * last score is stored
   * history is updated with the latest quiz result
6. Result screen shows performance and allows replay
7. Home screen displays updated statistics and quiz history

---

## Screens

### Home Screen

* Welcome section
* Statistics dashboard
* Quiz category list
* Quiz history list

### Question Screen

* App bar with category name
* Question counter
* Progress indicator
* MCQ options
* Next / Finish button

### Result Screen

* Final score
* Correct / wrong answer count
* Play Again button
* Back to Home button

---

## Dependencies Used

Some important packages used in this project:

```yaml
provider:
go_router:
shared_preferences:
dio:
```

---

## Installation & Run

1. Clone the repository:

```bash
git clone https://github.com/your-username/flutter_quiz_master_app.git
```

2. Go to the project folder:

```bash
cd flutter_quiz_master_app
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

---

## Learning Outcomes

This project demonstrates:

* Flutter UI development
* REST API integration
* JSON parsing and model handling
* State management with Provider
* Navigation using GoRouter
* Local persistence using SharedPreferences
* Theme management (Light/Dark mode)
* Clean app structure and reusable widgets

---

## Author

**Name:** Zarin Tasnim Elahi
**Project:** Flutter Quiz Master App

---

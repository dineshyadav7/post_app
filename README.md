# Fetch and Store Posts

Overview

This Flutter application fetches data from the public JSONPlaceholder API, stores it locally using SQLite (sqflite package), and displays the data in a list format.

Features

Fetch posts from JSONPlaceholder API

Store the fetched posts locally using SQLite (sqflite package)

Display the posts in a ListView with title and body

Technologies Used

Flutter

Dart

HTTP package for API calls

Sqflite package for local database storage

Setup Instructions

Prerequisites

Ensure you have Flutter installed. If not, install it from Flutter's official site.

Install dependencies by running:
flutter pub get

Running the Project

Clone the repository:

git clone <repository-url>

Navigate to the project directory:

cd project-directory

Run the application:

flutter run

Implementation Details

Fetching Data

The application uses the HTTP package to fetch posts from the JSONPlaceholder API.

Storing Data Locally

The fetched data is stored in an SQLite database using the sqflite package.

The database persists data so that it remains available even when the app is restarted.

Displaying Data

A ListView is used to display the posts.

Each list item shows the title and body of a post.

Dependencies

Ensure the following dependencies are added in pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  http:
  sqflite: 
  path_provider:

License

This project is licensed under the MIT License - see the LICENSE file for details.

Contact

For any issues or improvements, feel free to open an issue or contribute to the repository.





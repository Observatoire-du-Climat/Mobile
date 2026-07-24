# Observatoire Citoyen du Climat – Mobile Application

This repository contains the mobile application, created with Flutter, for the Observatoire Citoyen du Climat project. It is developed as part of a Bachelor's thesis at HEIG-VD.

The application allows citizen to collect climate-related observations and submit them to a centralized platform through a REST API, provided by the project web application.

You can find more about the web application [here](https://github.com/Observatoire-du-Climat/Web).

Currently, the application has only been tested on Android, but it is planned to work on iOS too.

## Context

This application was developed as part of a Bachelor's thesis at HEIG-VD in collaboration with the **Parc naturel régional Jura vaudois**.

The objective of the project is to provide a digital platform allowing citizen observers to collect and submit climate-related observations.

## Features

The application provides the following features:

* User registration and authentication
* Climate measurement submission
* Measurement history
* Profile management
* Push notifications

## Project Structure

The application follows a layered architecture based on the BLoC pattern.

`lib`
- `/bloc` - Business logic and state management
- `/model` - Data model
- `/repositories` - Abstraction layer between BLoCs and web providers.
- `/ui` - Pages and widgets
- `/utils` - Utility class
- `/web_providers` - Providers to communicate with the web servers through REST API


## Prerequisites

To run the project, you need :

* Flutter SDK
* Dart SDK
* Android studio or Visual Studio Code
* An Android emulator or a physical Android device
* A running instance of the backend application

Create a `.env` file at the root of the project containing the backend URL:

```
BASE_API_URL=${URL}

example : BASE_API_URL=0.0.0.0:8080/api
```

If you are using the web server locally in development mode, you will need to put your IP v4 address.

## Running the Application

Install the project dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

Run the test:

```bash
flutter test
```
# Delivery Test

A mock application developed using Flutter and Dart, designed to demonstrate a simple delivery service. This app serves as an example of how to build a basic Flutter application with a API calls, dependency injection, state management, and implementation of MVC architecture. Additionally, the app supports both light and dark modes and leverages a design system package for consistent UI components.

### [Delivery Test Web Example](https://wellingtonbipo.github.io/delivery_test/)

## Features

- **Mock API/Backend**: The app uses a mock backend hosted on GitHub. The backend consists of a simple JSON file, which is downloaded and parsed within the app to simulate fetching data from a server. This approach allows for easy testing and modification without the need for a live server.

- **Dependency Injection and State Management with Provider**: The app utilizes the Provider package to inject and manage the state across the application. This ensures a clean separation of concerns and makes it easier to manage and update the app's state in response to user interactions or data changes.

- **Light and Dark Mode Support**: The app includes a theme management system that supports both light and dark modes mirroring the device system mode.

- **Design System Package**: A design system package is used to ensure consistent styling across the app. This package contains reusable components, such as buttons, text styles, and colors, which adhere to a unified design language.

- **Testing**: The app includes a suite of tests to ensure its reliability and correctness.

- **Web Example**: An example of the app running on the web is provided. This demonstrates the cross-platform capabilities of Flutter, allowing the same codebase to run on mobile, desktop, and web platforms.
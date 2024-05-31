# Event Registration Form App

![System Design]![Form Generation App](https://github.com/kathankraithatha/common-registration-form-app/assets/99482358/d20bcaf8-3372-4481-b4a0-ce143c0696cc)


## Overview

Welcome to the Event Registration Form App! This application streamlines the process of registering for events by auto-filling basic user details, making the registration process quick and efficient. Additionally, administrators have the capability to create custom forms for users to fill out.

## Features

- **User Registration**: Allows users to register for events with their basic details auto-filled.
- **Admin Form Creation**: Admins can create customized registration forms.
- **Auto-Fill User Details**: Users can fetch their basic details automatically with a single click.
- **Seamless Navigation**: User-friendly interface with easy navigation.

## Screenshots

### Home Screen
![Home Screen](path/to/home-screen.png)

### Registration Form
![Registration Form](path/to/registration-form.png)

### Admin Form Creation
![Admin Form Creation](path/to/admin-form-creation.png)

## Getting Started

Follow these instructions to set up the project on your local machine.

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed
- [Firebase](https://firebase.google.com/) project setup

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/your-username/event-registration-form-app.git
    ```

2. Navigate to the project directory:
    ```bash
    cd event-registration-form-app
    ```

3. Install dependencies:
    ```bash
    flutter pub get
    ```

4. Set up Firebase:
   - Go to the Firebase Console.
   - Create a new project and add an Android/iOS app to it.
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files.
   - Place these files in the appropriate directories:
     - `android/app` directory for `google-services.json`.
     - `ios/Runner` directory for `GoogleService-Info.plist`.

5. Run the app:
    ```bash
    flutter run
    ```

## Usage

### User Registration

1. Open the app and navigate to the registration form.
2. Click the "Fetch Details" button to auto-fill your basic information.
3. Complete any additional fields and submit the form.

### Admin Form Creation

1. Log in as an admin.
2. Navigate to the form creation section.
3. Create and customize the registration form.
4. Save the form and make it available for users to fill out.

## System Design

![System Design](path/to/system-design-image.png)

The system is designed to separate user and admin functionalities effectively. Users can quickly register for events using forms that auto-fill their basic information, while admins have the flexibility to create and manage these forms.

## Contributing

We welcome contributions from the community. If you'd like to contribute, please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or feedback, feel free to reach out:

- **Email**: contact@yourdomain.com
- **GitHub Issues**: [Create an Issue](https://github.com/your-username/event-registration-form-app/issues)

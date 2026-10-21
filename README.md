# Family Finance Management

A Flutter-based family finance application developed to explore secure authentication, mobile application development, and integration with Google services.

This repository is a portfolio version of a personal project. Private configuration, account information, and financial records are excluded.

## Project Overview

Family Finance Management provides a mobile entry point to a restricted Google Sheets financial workspace.

The application combines Google Sign-In, backend identity verification, biometric authentication, and controlled access to a shared financial spreadsheet.

## Key Features

- Google Sign-In authentication
- Backend-based identity and role verification
- Biometric authentication using device-supported methods
- HTTP API integration
- Google Sheets integration through URL launching
- Restricted-access design for authorised users

## Technology Stack

- Flutter and Dart
- Google Sign-In
- REST-style HTTP requests
- Google Apps Script authentication backend
- Google Sheets
- Local biometric authentication
- Git and GitHub

## Authentication Architecture

1. A user signs in using their Google account.
2. The Flutter application obtains a Google ID token.
3. The token is submitted to the authentication backend.
4. The backend is designed to verify the identity and enforce account-based access rules.
5. Authorised users can proceed to the Google Sheets workspace.

Spreadsheet permissions provide an additional access-control layer.

## Security Considerations

- Account authorisation is enforced by the private backend design.
- Authentication and role decisions should not rely solely on the Flutter client.
- Google Sheets sharing permissions must be configured independently.
- Private backend configuration and spreadsheet identifiers are excluded from this repository.
- The public project uses placeholder configuration values.

## Running the Project

Install Flutter and download the project dependencies:

```bash
flutter pub get```

Review and replace the placeholder values in:

- `lib/api_config.dart`
- `lib/google_sheets_config.dart`
- `lib/google_login_page.dart`

Configure your own Google OAuth credentials, authentication backend, and Google Sheets permissions.

Run the application:

```bash
flutter run
```

**Important:** Authentication and spreadsheet access will not work with the placeholder configuration. Platform-specific Google Sign-In configuration may also be required.

## Project Status

Portfolio demonstration of an independently developed family finance application. The original project uses private services and restricted account access.

## Skills Demonstrated

- Flutter application development
- API integration
- Authentication workflows
- Role-based access-control concepts
- Secure configuration practices
- Integration with external services
- Git version control

## Disclaimer

This repository is provided for portfolio and educational purposes. It does not include the private authentication backend, production credentials, or real financial data.

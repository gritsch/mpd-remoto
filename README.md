# Remoto


![Remoto welcome screen](screenshots/Screenshot%20welcome%20screen.png)

Remoto is the best way to fix home network problems and ensure a productive environment for working from home.

Remoto is a B2B solution that makes home networks reliable, simple and secure for working from home.

Our users are the company's employees, which are enabled to fix problems themselves and get a better understanding of their home network.

## Project background

For the module "Managing Product Development" of the curriculum at the [Center for Digital Technology and Management](https://www.cdtm.de), students work for one semester on a project proposed by a project partner, the Deutsche Telekom AG.

The first of three phases of the project focuses on understanding the problem, the second phase is about ideation and idea generation, and in the last phase, a prototype/proof of concept for the product is developed.

This prototype shows how an app for Remoto could look like. Focus of the prototype is to showcase the UI design, the UX/flow through the app, and a selection of features. Features are mostly mocked, however, as the implementation does not include the necessary router integration.


![Remoto welcome screen](screenshots/Screenshot%20cockpit.png)

## Technologies

The prototype was developed as a frontend-only cross-platform flutter app.

## Running the prototype

Flutter version: 3.0.4 (Stable channel)

Tested development platforms:
- macOS 12.5 21G72 darwin-arm/XCode 13.4.1 with iPhone 13 Emulator/Android Studio with Pixel 3 Emulator/IntelliJ 2022.2
- Windows 10/Android Studio with Pixel 3 Emulator/IntelliJ

Tested deployment platforms:
- Samsung A50 with Android 11

To run the prototype:
1. Clone this repository into a local folder
2. Install [flutter](https://flutter.dev/)
3. Run `flutter doctor` in your terminal and install all required additional software
4. List all available devices with `flutter devices`
5. Open the project in your IDE (recommended: IntelliJ)
6. Run `flutter pub get` to install all dependencies from `pubspec.yaml`
7. Choose one of these options:
    * Run the prototype in an iOS/Android simulator on your computer with `flutter run`
    * Install the prototype on your phone by connecting it via cable to your computer, selecting it in your IDE and the running `flutter run --release`

## Meet the team

**Coding:** Noah Ploch, Nikolas Gritsch

**UI design:** Annabell Schäfer, Leonard Wolters, Noah Ploch, Nikolas Gritsch

**UX design:** Annabell Schäfer, Leonard Wolters, Noah Ploch, Nikolas Gritsch

**Prototyping:** Annabell Schäfer, Leonard Wolters

**Testing/user feedback:** Annabell Schäfer, Leonard Wolters, Noah Ploch, Nikolas Gritsch

**Business model:** Annabell Schäfer, Leonard Wolters

# TabBarProject

## Description

TabBarProject is a simple iOS application that demonstrates the usage of a tab bar controller with two tabs and a splash screen. The app allows users to manage a list of items and mark them as favorites. It is built using UIKit, RxSwift, and MVVM architecture.

## Features

### Splash Screen:

Displays a loading spinner and text.

Automatically transitions to the main application after 2 seconds.

### First Tab:

Displays a list of items (minimum of 20 items).

Allows users to select/deselect items as favorites.

Provides a "Select All/Deselect All" button for bulk selection.

### Second Tab:

Displays a list of favorite items.

Allows users to remove items from favorites individually or in bulk.

### Technologies Used

**UIKit:** For UI components.

**RxSwift:** For reactive programming and data binding.

**MVVM:** To maintain a clean separation between business logic and UI.

## Installation

**Prerequisites**

Xcode 14.0 or later

iOS 16.0 or later as the deployment target

CocoaPods for dependency management

### Steps

1. **Clone the repository:**
```
git clone <repository-url>
```
```
cd TabBarProject
```

2. **Open the project:**
```
open TabBarProject.xcworkspace
```

3. **Resolve Swift Package dependencies:**

- Open the project in Xcode.

- Go to ```File > Swift Packages > Resolve Package Dependencies```

4. **Build and run the application in the simulator or on a physical device.**

## Project Structure
```
TabBarProject
├── AppDelegate.swift
├── SceneDelegate.swift
├── ViewModels
│   ├── FirstTabViewModel.swift
│   ├── SecondTabViewModel.swift
│   ├── SplashViewModel.swift
├── Views
│   ├── FirstTabView.swift
│   ├── SecondTabView.swift
│   ├── SplashView.swift
├── Models
│   ├── Item.swift
├── TabBarController.swift
└── Resources
```

## Key Files

**SplashView**: Implements the splash screen with a spinner and loading text.

**FirstTabView:** Displays a list of items with options to select/deselect.

**SecondTabView:** Displays favorite items with removal options.

**TabBarController:** Configures the tabs and sets up the root view controller.

**Item.swift:** Defines the Item model structure.

## Usage

**Launch the app.**

Wait for the splash screen to load and transition to the main app.

**Navigate between tabs to:**

Select or deselect items in the first tab.

**View and manage favorite items in the second tab.**

Use the "Select All/Deselect All" button in the first tab and the "Remove All" button in the second tab for bulk operations.

## Screenshots

### Splash Screen

Displays a spinner and "Loading items..." text.

### First Tab

A list of items with checkmarks to select/deselect favorites. Includes a "Select All/Deselect All" button.

### Second Tab

A list of favorite items with options to remove items individually (swipe) or in bulk ("Remove All" button).

## Known Issues

None

## Future Improvements

Add persistence for selected items using local storage (e.g., Core Data or UserDefaults).

Enhance UI with custom designs.

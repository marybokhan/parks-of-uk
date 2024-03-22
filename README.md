# National Parks of the UK

## Description

This app is a comprehensive guide to the national parks of the United Kingdom, offering detailed information and insights.

## Tech stack

Initially developed using UIKit, the app has undergone significant evolution in its second release. 

Key updates and enhancements include:
- Transition to SwiftUI for a more modern and responsive interface;
- Integration of existing UIKit views within the SwiftUI framework;
- Implementation of `async/await` alongside `AsyncImage` for enhanced performance and smoother image loading;
- A refreshed design that improves user interaction and visual appeal.

Technologies Utilized:
- **SwiftUI**: For building the user interface;
- **UIKit**: Integrated within SwiftUI for specific UI components;
- **Async/Await**: For efficient handling of asynchronous code, improving app responsiveness;
- **AsyncImage**: For optimized image loading and rendering;
- **JSONDecoder**: To parse and utilize data efficiently within the app.

## Requirements

**iOS Version**: Requires iOS 17 or later.\
This requirement ensures compatibility with the latest SwiftUI features and improvements introduced in iOS 17, representing a significant evolution of the framework, simplifying the usage of property wrappers, and enabling more sophisticated UI designs.

## Preview

<p align="center">
    <img src="media/parks_uk.png", width="600">
</p>

## Sources

- *My project refactoring was inspired by the following Apple’s Tutorial “Introducing SwiftUI”: https://developer.apple.com/tutorials/swiftui.*
- *Parks’ Images and Text were sourced from National Parks UK: https://www.nationalparks.uk.*
- *Placeholder Image was sourced from https://berkeleyca.gov.*
- *App Icon was generated using the Draw Things app: https://drawthings.ai.*
## License

[MIT](LICENSE)
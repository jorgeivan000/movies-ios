# Contributing

Here are guidelines and standards in order for you to add functional code to this code base.

## Getting started

Must read:

* [How to Code Review](https://github.com/yellowme/guides/tree/master/code-review)
* [How to Swift](https://github.com/yellowme/guides/blob/master/code-review/SWIFT.md)

## About the project structure

Considerations:

- `data` folder contains everything to access local storage (user defaults) or to make server requests (Alamofire).
- `presentation` folder uses *feature grouping* to structure its inner folders. This means that regardless the type (presenter, view controllers, cells, etc..) you will have everything related to a single feature.
- `domain` folder contains structs and server response related models.
- `common` folder contains all the architecture hooks
- `components` folder contains shared classes acroos the app like alerts, fields and validations, MVP components, cells, etc.

### Project Structure

`com.enso`

    ├─ app
    ├─ common
      ├─ extensions
      └─ helpers
    ├─ components
    ├─ data
      ├─ local
      └─ remote
    ├─ domain
    └─ presentation
      ├─ welcome
      ├─ signin
      ├─ signup
      ├─ home
      └─ onboarding

*Note:* Main folder might differ naming.

## Connect to an API

TODO: Add steps and examples.

## MVP

This section explains how to use MVP hooks created for you to add components within the rules of the project mini-framework.

### Create a Contract

TODO: Add steps and examples.

### Create a Presenter

TODO: Add steps and examples.

### Create an Activity

TODO: Add steps and examples.

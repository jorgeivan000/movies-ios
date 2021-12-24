# Enso iOS App

## Table of Contents

* [Requirements](#requirements)
* [Getting Started](#getting-started)
* [Setup](#setup)
* [Config](#config)

### Requirements

* Xcode 10.3 or above
* Swift 4.2 or above
* Cocoapods 1.5 or above
* iOS 13 or above

### Getting Started

Read all the documents inside our [Docs folder](./Docs).

### Setup

For development setup, please follow the following instructions:

#### 1. Clone the repository and enter the folder

```bash
git clone git@bitbucket.org:yellowme/enso-ios.git
cd moviesapp-ios
```

#### 2. Go to development workspace

```bash
git checkout -b develop origin/develop
```

#### 3. Open the app with Xcode

#### 4. Chose MoviesApp Target

#### 5. Clean and build (Important!)

#### 6. Add config files

Go to [config](#config) section

#### 7. Run `pod install`

Some case you might need to run `pod repo update` befor installing dependencies.

#### 8. Run the app

### Config

Before use the application features you must properly configure the project variables for the different environments.

**Note:** Contact your project manager or team leader in order to get the files.

#### 1. Locate `.xcconfig` files

You are looking for the files named :

1. MoviesAppDevelop.xcconfig
2. MoviesAppProduction.xcconfig
3. MoviesAppTest.xcconfig
4. MoviesAppStaging.xcconfig

**Important:** This files must be located on `MoviesApp/Config` folder.

#### 2. Add project variables

On each file you need to replace the variables with the proper values.

Variables to be replaced:

CONFIG_NAME = `XXXXXXXXXXX`
PRODUCT_BUNDLE_IDENTIFIER = `XXXXXXXXXXX`
CORE_API_URL = `XXXXXXXXXXX`
CORE_API_VERSION = `XXXXXXXXXXX`
URL_TYPE_SCHEME = `XXXXXXXXXXX`
TMDB_API_KEY = `XXXXXXXXXXX`

*Note:* In case of not having a key/value please contact your project manager or team leader.

#### 3.  Add variables to Info.plist

On the project Info tab, under Custom iOS Target Properties, add your required variable keys
* CoreAPIURL = `$(CORE_API_URL)`

#### 3.  Register variables on  InfoPlistHelper
**Important:** This files must be located on `MoviesApp/Commom/Helpers/` folder.

Add the keys that represent the variable name given on the Info.plist file

```bash
enum InfoPlistKey: String {
    case api = "CoreAPIURL"
    case apiVersion = "CoreApiVersion"
    case bundleShortVersion = "CFBundleShortVersionString"
    case environmentName = "CFBundleDisplayName"
}
```
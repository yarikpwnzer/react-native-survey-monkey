
# Survey Monkey for React Native (react-native-survey-monkey)
  
Platforms:
- iOS
- Android (comming soon in few days)

## Installation

### Install Node Package

#### Option A: yarn

```shell
yarn add https://github.com/yarikpwnzer/react-native-survey-monkey
```

#### Option B: npm

```shell
npm install https://github.com/yarikpwnzer/react-native-survey-monkey --save
```

### iOS

#### Option A: Install with CocoaPods (recommended)

1. Add this package to your Podfile

```ruby
pod 'react-native-survey-monkey', path: '../node_modules/react-native-survey-monkey'
```

Note that this will automatically pull in the appropriate version of the underlying `Survey Monkey` pod.

2. Install Pods with

```shell
pod install
```

#### Option B: Install without CocoaPods (manual approach)

1. Add the SurveyMonkey dependency to your Podfile

```ruby
pod 'surveymonkey-ios-sdk', '~> 2.0'
```

2. Install Pods with

```shell
pod install
```

3. Add the XCode project to your own XCode project's `Libraries` directory from

```
node_modules/react-native-survey-monkey/ios/RNSurveyMonkey.xcodeproj
```

4. Add `libRNSurveyMonkey.a` to your XCode project target's `Linked Binary With Libraries`

5. Update `Build Settings`

Find `Search Paths` and add `$(SRCROOT)/../node_modules/react-native-survey-monkey/ios` with `recursive` to `Framework Search Paths` and `Library Search Paths`

### Android

Not ready in this version of library, will be ready in couple days.

## Usage

We have three important components to understand:

```javascript
import SurveyMonkey from 'react-native-survey-monkey';
```

Example:

````javascript
import React, { PureComponent, createRef } from 'react';
import SurveyMonkey from 'react-native-survey-monkey';
import {
  View,
  Text,
  TouchableOpacity
} from 'react-native';

export default class Example extends PureComponent {
  constructor(props) {
    super(props);
    
    this.onTouch = this.onTouch.bind(this);
    this.surveyMonkeyRef = createRef();
  }
  
  onTouch() {
    this.surveyRef.current.showSurveyMonkey('some hash');
  }

  render() {
    return (
      <View style={styles.container}>
        <SurveyMonkey ref={ this.surveyMonkeyRef } />
        <TouchableOpacity
          style={ styles.button }
          onPress={ this.onTouch }
        >
           <Text styles={ styles.buttonText }>
             Show survey
           </Text>
        </TouchableOpacity>
      </View>
    );
  }
}

AppRegistry.registerComponent('Example', () => Example);
````

## More features:

Getting respondent data:

````javascript
  <SurveyMonkey
    ref={ this.ref }
    onRespondentDidEndSurvey={ (data) => {
      console.log('Respondent', data.respondent);
      console.log('Error', data.error);
    } }
  />
````

'Cancel' button tint color:

````javascript
  <SurveyMonkey
    ref={ this.ref }
    cancelButtonTintColor="#000000"
  />
````

You can add custom variables:

````javascript
  onTouch() {
    this.surveyRef.current.showSurveyMonkey('some hash', { var1: 'var1', var2: 'var2', ... });
  }
````

Schedule Intercept (ios: scheduleInterceptFromViewControllerWithTitle):

````javascript
  onTouch() {
    this.surveyRef.current.showSurveyMonkey('some hash', null, 'Title');
  }
````

Schedule Intercept with Params (ios: scheduleInterceptFromViewControllerWithParams):

````javascript
  onTouch() {
    this.surveyRef.current.showSurveyMonkey('some hash', null, null, {
      title: 'Title',
      body: 'Body',
      positiveActionTitle: 'positive',
      cancelTitle: 'cancel',
      afterInstallInterval: 10,
      afterAcceptInterval: 10,
      afterDeclineInterval: 10
    });
  }
````

## Contact

- Yaroslav Fuchko (iOS) <yarikpwnzer1@gmail.com>


# react-native-survey-monkey

## Getting started

`$ npm install react-native-survey-monkey --save`

### Mostly automatic installation

`$ react-native link react-native-survey-monkey`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-survey-monkey` and add `RNSurveyMonkey.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNSurveyMonkey.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNSurveyMonkeyPackage;` to the imports at the top of the file
  - Add `new RNSurveyMonkeyPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-survey-monkey'
  	project(':react-native-survey-monkey').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-survey-monkey/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-survey-monkey')
  	```

#### Windows
[Read it! :D](https://github.com/ReactWindows/react-native)

1. In Visual Studio add the `RNSurveyMonkey.sln` in `node_modules/react-native-survey-monkey/windows/RNSurveyMonkey.sln` folder to their solution, reference from their app.
2. Open up your `MainPage.cs` app
  - Add `using Survey.Monkey.RNSurveyMonkey;` to the usings at the top of the file
  - Add `new RNSurveyMonkeyPackage()` to the `List<IReactPackage>` returned by the `Packages` method


## Usage
```javascript
import RNSurveyMonkey from 'react-native-survey-monkey';

// TODO: What to do with the module?
RNSurveyMonkey;
```
  
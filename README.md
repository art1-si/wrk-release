# workout notes

This is an app that will help you track your workouts. 
The app was made in mind to make for a user process easy and simple to log and view progress in a gym.
[Play Store](https://play.google.com/store/apps/details?id=workout.notes_app)

## Project Goals
Showcase basic understanding of app design, data models, firebase API, flutter framework, dart language, animation in flutter and riverpod package for state management, as well as code generators like freezed and JSON serializable.


## Offline to Firebase conversion

The release version of an app uses sqlfile as a database, 
but the code is set up in the way that you can yourself quickly make it online with firebase by changing and adding a bit of code.
### Step 1 add firebase to flutter project
tutorial for android you can find here https://firebase.google.com/docs/flutter/setup?platform=android
and for IOS you can find here https://firebase.google.com/docs/flutter/setup?platform=ios

### Step 2 enable online mode
at \lib\constants\offline_mode.dart file just change value to false and it should work.

If you have any questions, feel free to text me.

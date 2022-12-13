# A simple Flutter web app for scheduling meetings

## How to build 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/chuonglam/schedule_booking.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

Run the app
```
flutter run
```
## Libraries

* [GetX](https://pub.dev/packages/get)
* [GetIt](https://github.com/fluttercommunity/get_it)
* [Injectable](https://pub.dev/packages/injectable)
* [Syncfusion Calendar](https://pub.dev/packages/syncfusion_flutter_calendar)

## Folder Structure
Here is the core folder structure.

```
schedule_booking/
|- common (contains constants/extensions functions, can be used by data/app module
|- data (contains services & repositories for getting data from network/local storage)
|- lib/
    |- common (contains common widgets, styles, app's validators)
    |- di (contains service locator setup)
    |- models (contains )
    |- screens (contains all UIs of the app)
        |- app (contains app bindings & routes)
        |- auth (contains auth features)
        |- create_schedule (contains creating new schedules feature)
        |- home (contains current user's schedules list)
        |- main (contains main screen)
    |- main.dart
|- screenshots/ (contains the app's demo .gif files)

```
## Features

**Data including in these screenshots:**

* User data:

User | username | email | displayName | shortcut
--- | --- | --- | --- | ---
1 | albert | albert@gmail.com | Albert | A
2 | benjamin | benjamin@gmail.com | benjamin | B
3 | connie | connie@gmail.com | Connie | C
4 | david | david@gmail.com | David | D
5 | elizabeth | elizabeth@gmail.com | Elizabeth | E
6 | fenik | fenik@gmail.com | Fenik | F

Password for all users: `chuong`
* Schedule data:

Schedule | host | participant | date | time
--- | --- | --- | --- | ---
1 | A | B | 12 Dec 2022 | 5:00p.m - 6:30p.m
2 | A | B | 12 Dec 2022 | 6:59p.m - 7:59p.m
3 | C | D | 12 Dec 2022 | 8:00p.m - 9:00p.m
4 | A | C | 12 Dec 2022 | 9:00p.m - 10:00p.m

or you can take an overview as below:

<img src="https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/schedules_data.png?raw=true" alt="drawing" width="350"/>



**Sign up:**
<kbd>
![Alt Text](https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/signup_desktop.gif?raw=true)
</kbd>

**Login:**
<kbd>
![Alt Text](https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/login_desktop.gif?raw=true)
</kbd>

**Create new schedule:**
```
The screenshot's actions:
0. Login as `Albert`.
1. Tap `Create schedule` menu. 
2. Click the Search button to list all the available users in the selected date (default is today).
3. Click to select a user (Benjamin in the screenshot).
4. Modify the duration to 1h30m.
5. Drag and drop the schedule bar at 17:00pm.
6. Click `Create` button to show the confirmation popup. Click OK to create new schedule.
```
![Alt Text](https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/create_schedule_desktop_success.gif?raw=true)


**Create new schedule failed because time overlaps:** 

Red boxes are your schedules, the blurry purple boxes are the selected user's schedules, and the purple one is the schedule picker.
<kbd>
![Alt Text](https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/create_schedule_overlaps.gif?raw=true)
</kbd>

**Filter list of users by available time slots:**
<p align="center">
<kbd>
<img src="https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/schedules_data.png?raw=true" alt="drawing" width="350"/>
</kbd>
</p>

* According to the schedules data overview above, if we (`Albert` or `A`) are going to search for users (who have at least one `1 hour` time slot) from `5:00pm` to `8:00pm`, the result should not include the user `B`:

![Alt Text](https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/filter_b.gif?raw=true)
c
* If we (`Albert` or `A`) are going to search for available users (have at least one available `1 hour` time slot) from `8:00pm` to `10:00pm`, the result should not include the user `C`:

![Alt Text](https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/filter_c.gif?raw=true)

**Sort list of users by available time slots:**

<img align="left" width="40%" src="https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/schedules_data.png?raw=true"> 

If we (`Albert`/`A`) want to search for a list of available users (have at least`1 hour` available time slot) from `5pm` - `9pm`, the result will be a list including: 

`B (available from 7:59pm)`

`C (available from 5pm)` 

`D (the same to C)`

`E (available at anytime)`

`F (the same to E)`

In case two users have the same available time, they always are ordered `ascending` by their account `created-date`.

The default sorting of the list is `ascending` by available time. Therefore, the result should be in order of `[E, F, C, D, B]`. 

If we select the sorting is `descending` by available time, the result should be `[E, F, B, C, D]`.

And here's the screenshot:

![Alt Text](https://github.com/chuonglam/schedule_booking/blob/develop/screenshots/sorting.gif?raw=true)

**More screenshots:**

Please take a look for a preview here: 

https://github.com/chuonglam/schedule_booking/tree/develop/screenshots


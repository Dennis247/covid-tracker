# covid_tracker

First thing, integrate your app with firebase.The covid tracker app uses the device id, location, Great circle distance plugin and realtime database to do the following.
1. Get the current location of your device.
2. Update your device current location to a real time database.
3. Compare other device location using the app which is being updated to the realtime database with yours.
4. The app uses vincenty formula to caluclate distance between you and other device using the app & within the hour.
5. if the distance falls within the accepatble contact distance(in my case i set at 6m in the constant.dart file), 
   the app records the user device as a contact.
6. These contacts are stored for tracing purposes. 
7. After 14 days(required qurantine period) of making contact, the contacts are auto deleted.

!Always make sure your location is turned on for realtime  tracking of contacts.

![alt text](https://github.com/Dennis247/covid-tracker/blob/master/lib/ss/screenshot.jpg)



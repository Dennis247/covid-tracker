# covid_tracker

First thing, integrate your app with firebase.The covid tracker app uses the device id, location, Great circle distance plugin and realtime database to do the following.
1. Get the current location of your device.
2. Update your device current location to a real time database.
3. Compare other device location which are being updated to the realtime database to with yours using the vincenty formula to find the device range from you within the acceptable distance(in my case i set it at  6 meters for demo purpose) & within the hour.
4. These contacts are stored for tracing purposes. 
5. After 14 days(required qurantine period) of making contact, the contacts are auto deleted.

Always make sure your location is turned on, to keep tracking contacts

![alt text](https://github.com/Dennis247/covid-tracker/blob/master/lib/ss/screenshot.jpg)



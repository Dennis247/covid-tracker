# covid_tracker

The covid tracker app uses the device id, location, Great circle distance plugin and realtime database to do the following.
1. Get the your current location
2. Update your device current location to a real time database.
3. Compare other device location which are being updated to the realtime database too with yours using the vincenty formula to find the device that has been close to you (contact) within the acceptable distance(in my case i set it at  6 meters) & within the hour.
4. These contacts are stored for tracing purposes. 
5. After 14 days(required qurantine period) of making contact, the contacts are auto deleted.



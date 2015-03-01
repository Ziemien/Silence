# Silence
Extremely simple app to change volume of the android device from OSX. It was built to work with Spotify Connect which at this moment doesn't allow for volume change which is pretty annoying.

There is probably loads of similar apps out there which allow to control different devices but I just needed something simple :)

It's probably a bit rubbish right now but it works.

Requires:
---------
  * PubNub pubnub.com
  * Cocoa Pods

Installation:
-----------
Just run `pod install` and you should be ready to go.

To-Do
---------
* Balance change
* Get Max volume from the device
* Maybe change it to use Bonjour service (I've tried initially, Android doesn't seem to work well with Network Service Discovery. I was too lazy to use sockets)
* Create background service on Android


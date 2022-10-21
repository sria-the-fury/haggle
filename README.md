# 5 Days of Flutter
## Haggle BD

An auction Application using flutter and firebase, is in progress instructed by [Taka.school](https://taka.school)

See the update design of Haggle name as HaggleBD - [Click to the repo](https://github.com/sria-the-fury/haggleBD).

Please uninstall previous version. New update - 16-aug-1625 is available.
Here is the build release ['APK Click here to Download'](https://drive.google.com/file/d/1UlP_7suMRv9nJW3oHPX8zxYCYNKJfneZ/view?usp=sharing).
I have tested it with two Android phones. As far as it is good. But if you get an issue or issues, please let me know.




### Package use:
- firebase_auth
- firebase_cloud_firestore
- firebase_storage
- google_auth

and use different kinds of package for building this application.

## Problem I have faced

I used Flutter more than two years ago, and honestly I am not a flutter stack.
Only I know the basics about. I have totally shifted myself in React and React Native.

Within this two years, many things have been changed of the technology. 
New methods have come to implement.
So if you don't stick on particular thing, it may fall you into some trouble.

But that doesn't mean that you don't know anything, or you can't do any things.
I honestly believe that anyone can do what they have to be effort. 
I have followed the official documentation for working on this project.
Nothing is more helpful than official documentation if it is well documented.
I wish I learn more things, if I stick with this.

- I have found difficulty to mapping firestoreJSONQuery. Mapping any data is easy on JavaScript. but I have figured out the way.
- Others are not so major problem. 

Maybe this is not the good way to build an application.
There has to be some plan how the files and code are organized  well, for that you have to need time for planning.

## Problem you may face
Confirm that you have everything installed correctly for running this project.

- check Flutter SDK
- Android SDK
- JDK
- last thing -> check /haggle/android/local.properties , place there your flutter sdk path.
- install the packages by 'flutter pub get'

## Let see some interface

- **_Home Page_** : In this portion users can see the auction ads posted by others. In every ad card users find how many people bid in this auction, the left people sign with number indicates this. Logged-in user see a light-orange color dollar sign if they have bid in this auction already.
![homePage](snapShots/Screenshot_20210814-155856_haggle.png "Home Page")
- **_Details Page_** : By tapping on each card, user can go to details page of this specific auction and can make bid if they want. Much valuable information are also found there, like a table of bid users which is sorted by high bid price. Bid users can edit their bid before end of the auction time. After ending of auction system will decide a winner who made high bid price among everyone.
![detailsScreen](snapShots/Screenshot_20210814-154112_haggle.png "Details Page")
![detailsScreen](snapShots/Screenshot_20210814-154145_haggle.png "Details Page after bidding")
![detailsScreen](snapShots/Screenshot_20210814-154204_haggle.png "Details Page edit bid")
![detailsScreen](snapShots/Screenshot_20210814-153837_haggle.png "Details Page when bid time is over no one mad a bid")
![detailsScreen](snapShots/Screenshot_20210814-153817_haggle.png "Details Page winner")
- **_How To ADD item for Auction_** : There is a plus icon floating button on home page. Any user can add their product for auction.
![Add item](snapShots/Screenshot_20210815-104324_haggle.png "Add item")
![add item](snapShots/Screenshot_20210815-104827_haggle.png "select time from auction button")
- **_Users gallery_** : Well, this is user section. users will find their items which they added for auction, and also find where they made a bid.
![user Screen](snapShots/Screenshot_20210814-153735_haggle.png "Users Page")
- **_Show users where they made a bid_**
![user Screen](snapShots/Screenshot_20210814-155000_haggle.png "Users Page")
- in progress ( User Profile )
![user Screen](snapShots/Screenshot_20210814-161629_haggle.png "Users Profile")
- **_Dashboard_** : All users can see about the auctions, completed of running and what is the total value of completed bid.
![Dashboard](snapShots/Screenshot_20210814-234530_haggle.png "Dash board")
- **_TimeLine of BidsPricePerDay_** : Shows a line graph auctions' minBidPrice relative to day.
![Dashboard](snapShots/Screenshot_20210814-235046_haggle.png "TimeLine")

## Connect
you can find me on Google by typing my name "Jakaria Mashud Shahria"
if you find any difficulty or need to contact, knock me on whatsapp or [telegram](https:t.me/jakariamsria)
or email me at [jakariamsria@gmail.com](mailto:jakariamsria@gmail.com),
or [shahria@oasisoneiric.tech](mailto:shahria@oasisoneiric.tech)

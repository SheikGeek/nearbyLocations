# nearbyLocations

Playing around with the Foursquare API and iOS

Here is a list of Tutorials and Resources I utilized:

[Intro to RestKit Tutorial] (http://www.raywenderlich.com/13097/intro-to-restkit-tutorial)  
[Performance Tips and Tricks] (http://www.raywenderlich.com/31166/25-ios-app-performance-tips-tricks)  
[Intro to Location Services w/ Mapkit] (www.raywenderlich.com/13160/using-the-google-places-api-with-mapkit)  
[Getting a User's location w/o a Map] (http://www.appcoda.com/how-to-get-current-location-iphone-user/)  
[Using NSCache] (http://stackoverflow.com/questions/5755902/how-to-use-nscache)  
[Foursquare Search Venues] (https://developer.foursquare.com/docs/venues/search)  
And MANY stackoverflow postings

## A Few Notes for Running the Project
I am using the Foursquare API, which means the project utilizes a ClientID and ClientSecret.  If this were a project I was going to submit to the app store, I wouldn't leave them in the project on github.  However since this was for learning purposes and a coding challenge, I decided to leave it in since this app shouldn't be getting much traffic.  

If you plan on running this on a device and you have a provisioning profile of your own (with it's own bundleID, then please feel free to use that.  You will however need to obtain your own ClientID and ClientSecret from Foursquare and register your bundleID with Foursquare to make the project obtain search results.  Once you obtain a ClientID and Client secret, replace the values defined at the top of LocationHelper.h with your values and the project should work!  

Currently the app is only searching for places related to "coffee".  If you would like to change this out with a different value, change the "query=coffee" parameter of URL on line 37 to "query=<whatever you want>".  

Please check the Enhancements section of this ReadMe to read about ways I would like to improve this and other parts of the app.

## The Process
Even though the main part of the challenge was to tackle creating a UITableView that displayed a list of nearby locations, I knew I wanted to tackle plotting those locations on a map.  So to do that, I was going to need to store the locations in a common file, that would then be shared by both the UITableView and the Mapkit view.  Since I also was pretty unfamiliar with how CLLocations and Mapkit worked, I decide I would start by implementing a mapview and finding my current location.  After that was working, I set up a request to Google's location API and created a Map Point class (as seen in Ray Wenderlich's tutorial for Mapkit).  I then switched over to Foursquare's API.  Once that was working I began to customize what data I wanted to store from the responses.  After everything looked good in a mapview, I moved on to implementing the tableview and formatting the data.  I then added some error handling (Mainly to validate data was being returned). Finally, I started adding some tests.

## The Struggles
Before attempting this challenge, I had never worked with any location based service (Foursquare, Yelp, Google Locations), CLLocations, Mapkit, StoryBoards or NSCache. Each one provided a different challenge, but were all pretty interesting to research/implement.  

### Location Based Services
The main issues I ran into here was that I originally started out trying to use Restkit (which still could be a better option), when I could have just stuck with the NSURL requests, which I had at least used a little bit before.  I think with more usage, I could understand how Restkit works and how the calls differ, in terms of performance, compared to NSURL requests.  I started off trying Google's Locations API, but quickly realized it wasn't going to return enough information for me to populate the tableview with all the information the mockup wanted.  So I switched to Foursquare, which turned out I could make requests in the same way I was using Google's locations API and I just had to handle the responses a little differently. 

### CLLocations
This class was my favorite to learn about.  It is easy to set up, but does so much with so few lines of code.  I did struggle at first with understanding that I could decouple it from the mapview functionality, but once I figured that out, it was really useful for getting the user's coordinates for either the tableview or mapview.

### Mapkit
I thought this was going to be the part of the challenge that was going to bring me down.  I thought I was going to somehow have to get a map, import it into the project and figure out how to render frames.  All of that was wrong.  In my Storyboard, I just had to add a mapview and use the corresponding delegate functions.  iOS took care of just about everything else.  I was then free to work on plotting points.

### Storyboards
I knew this was something I really should have known how to use, but since I started working in iOS, I have only ever used .xib files.  I'm glad I learned about .xib files so that I could understand how the viewControllers work with them (hooking up objects, hooking up functions, managing 1:1 relationships, etc.), but storyboards make all that logic work more seamlessly.  By adding a navigation controller, I could change the color of the nav/status bar.  I could edit the bar button item attributes right there.  I could even connect views (and their underlying view controller flow) in the storyboard. I don't think I'll be going back to using .xibs all by themselves anytime soon.

### NSCache
I had read about this previously, but never actually tried using it.  I unfortunately made the mistake of trying to integrate this at the very end of implementing this project, which wasn't really bad, but I felt like I wasn't using it properly.  After doing some further reading on it, I realized it is basically just an iOS owned NSMutableDictionary.  Since my plan of using it was to help the data persist when there was no network activity, I realized I didn't really need it (maybe later as a future enhancement).  I had already created a mutable storage object to hold all of my data in case of a network timeout.  The only problem with using a mutable structure or NSCache, is the data doesn't persist when you kill the app completely.  If I were to re-implement this part later and narrow down the amount of items returned from Foursquare, I might try storing these items in a plist or flatfile within the apps filesystem on the device. I would then be able to check that when no connection is available. This could cause some security issues though as we don't necessarily want the user's location to be available when the app isn't running.

## Enchancements
There are definitely a lot of ways I could improve the app and a few ideas I have to implement portions of the app differently.

### Data loading in the project  
I am using asynchronous loading currently, which has it's pros and cons.  The good news is, the data can load without disrupting other functionality in the app.  The bad news is, nothing in the app can really happen until data is obtained.  It would be good if I switched to a "lazily loading" method or made the app use some sort of "next page is loading" screen.

### NSCache vs. Flat Files vs. NSMutableDictionary
I debated about what to use to store data for quite a while.  I am most familiar with NSMutableDictionaries, which is what I ended up going with since I was taking on a significant amount of new classes and libraries to learn.  As mentioned above, Flat Files would provide the most usage between sessions of the app, however large amounts of data and security could be a concern.  NSCache would also be a better choice than using an NSMutableDictionary, since it handles garbage collection in low memory situations.

### Foursquare API choice
I ended up using the Venue Search API, which provides a lot of data, but unfortunately, not enough data.  I would like to switch to the Venue Explore API, which would enable me to pull a venues hours to figure out if they are open or closed, the venues icon to be displayed instead of the Foursquare category and maybe even data about a Venues popularity.

### UITableView data display
I ran into some issues with displaying correct data.  Since I had some API limitations with the Foursquare API I chose to use, I was not able to pull certain attributes that would make each Venue Cell more polished.  As mentioned above, a Venue icon and hours would have fixed the two main issues with the cell.

### Mapview
The Mapview currently has limited functionality.  I am statically setting the radius at which the points are displayed and there is no zoom capability.  By making the radius for search results dynamic (based on the zoom level of the user's choosing) I could allow for much more specific or vague results.  The annotations could be a little more detailed and even more so polished.  Maybe they could even include all the same data as the Venue table cells, for consistency.

### Details View
I currently did not implement a detail view to be displayed when a user clicks on a Venue table cell.  Similar to Foursquare, Belly and Yelp, it would be nice for each Venue to take the user to a more detailed page about a Venue.

### Keyword search capability
The app currently defaults to searching for "coffee", but it would be nice if the user could search for whatever they want or are looking for in a venue.

### Better tests
If I were to redo this project, I would use Test Driven Development.  This would have made setting up the NSURLRequests so much easier.  I also came across some pretty interesting Location based mockup classes specifically for testing, which would really enhance this app's unit testing.

### More User-friendly errors
I only added a few alerts around Network connection, but there are so many other things that could go wrong.  It would be good to add some more error handling that gives the user a more precise error message.

### OAuth integration to allow sharing between friends
By adding the Foursquare OAuth calls, this would open up some more options for personalized data.  Users could see if their friends have been to a Venue, share Venues with friends, give Venues ratings, etc.

### Suggestions based on Foursquare user's previous venues visited
If the user is able to login to the app, I could keep track of a seperate view that shows the user their most recent venues or somehow denote recent venues on the current tableview.  Off of that, the app could provide suggestions of new venues to check out.

### Type in location instead of enabling location services
Some users might not want to enable the extra services, so adding an option to search for venues in specific cities or regions might be a nice alternative.

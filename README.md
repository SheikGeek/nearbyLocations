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
I had read about this previously, but never actually tried using it.  I unfortunately made the mistake of trying to integrate this at the very end of implementing this project, which wasn't really bad, but I felt like I wasn't using it properly.  After doing some further reading on it, I realized it is basically just an iOS owned NSMutableDictionary.  Since my plan of using it was to help the data persist when there was no network activity, I realized I didn't really need it (maybe later as a future enhancement).  I had already created a mutable storage object to hold all of my data in case of a network timeout.  The only problem with using a mutable structure or NSCache, is the data doesn't persist when you kill the app completely.  If I were to re-implement this part later and narrow down the amount of items returned from Foursquare, I might try storing these items in a plist and checking that to help items persist across full app restarts.

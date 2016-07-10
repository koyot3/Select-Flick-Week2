User Stories
#Search (Pull Request 1)
[x] User must be able to search, using the /search endpoint.

There should be a third tab, called search.


User must be able to filter search results by adult content, release year, and primary release year, which are parameters to /search in the TMDB API. This should be done via a second view controller, called "filters". 
User should see a "no results found" placeholder in the table view if no results are found.
Favoriting and Sharing (Pull Request 2)
User should be able to swipe right on the TableViewCells to expose favorite and share actions. 
Movies that have been "favorited" should have a visual cue that they've been favorited, such as an icon or change in background color.
Make sure the "favorited" state persists as you scroll up and down the list of movies.
Selecting "share" should open a small ActionSheet that looks like this:


Note for this step, the app does not need to remember which movies you've favorited between steps.
Now, you'll be working on two branches off of Pull Request 2.

Persisted Favoriting using Realm (Pull Request 3)
Closing the app and re-opening the app should "remember" the movies that you've favorited.
Local persistence: use Realm to remember which movies you've favorited.
Hint: you'll want to use the id field to correlate the movies together.
Persisted Favoriting using Firebase (Pull Request 4)
Sign up for an account using Firebase: https://www.firebase.com/docs/ios/quickstart.html.
Save your "favorited movies" to Firebase.
Bonus Tasks.
Integrate MGSwipeTableCell to implement bi-directional swipe. Swipe left to favorite, and swipe right to share. Swipe left to favorite should trigger automatically upon completion of the swipe.
Firebase Branch: Implement a "Feed View", where you can see all the favorite actions happening in a TableView.
Resources
http://www.appcoda.com/social-framework-introduction/ - Tutorial on how to use Sharing.
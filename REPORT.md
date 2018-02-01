# Final Report

The app allows users to create accounts, search and look through the collection of the Rijksmuseum through their API, and
create collections with these art works as well as look at collections made by other users.

Once the user has logged on, the app takes them to a tab bar controller, consisting of 4 tabs. 

Screenshot -> ( tab bar )

2 of these "tabs" contain view controllers, one in which the user can search for other users through the Firebase database,
and one where the user can search through the collection of the Rijksmuseum.

screen( search view)

The 2 other tabs are table views, one in which the "likes" (collections of other users) are displayed, and one in which the 
users own collections are displayed.

screen (table views)

In each table view the cells are pressable and will perform a segue leading to more detail about either the collection or the
specific artwork. 

screen( detail example)

A fresh user will not have any collections or likes, and the table views will thus be empty initially since they retrieve their
data from Firebase. 
In the search view controller, a URL is created with the user input in the text field once the search button is pressed. This
URL is then used to obtain information from the Rijksmuseum API via a GET request which will return search results in a JSON 
format. This data is decoded using a json decoder and put into the structs that mimic the data format of this data.

Screen (structs in which data is put) Screen (rijks api data)

After the search button is pressed, the user will be taken to the search result table view controller, which puts the these
results (obtained as described above) in individual, pressable cells. Pressing these cells will prepare a segue that takes 
the user to the detail view controller, where detailed information about the relevant artwork is obtained by using the 
objectNumber (which is passed to it from the previous view controller). 

In the detail view controller, the user has the option to add the artwork to a consisting collection, or create a new one. 
This is both done via Firebase.

Screen (Firebase database)

Once a user has created a collection, it will be viewable in the first tab (named "Collections"). In this tab view controller
data for the individual cells is obtained from firebase through the startObserving function. 
-> screen (start observing)
This Collection table view is also used to display the collections made by other users if the user gets there via the 
SearchOtherUsers view controller. Keeping track of which collections to show and what to "Observe" is done through
the otherUser boolean which is changed based on the segue.

Roughly the same goes for the other table views, in which data is obtained from firebase based on the relevant user.

The Classes: 
class RecentUsersTableViewController --> Loads "Liked" data from Firebase for the logged in user via the observe() function
and displays data in pressable cells.

class LoginViewController -->  Initial view controller which handles user authentication and registration.

class DetailViewController --> Presents detailed information about the artWork using the data that is passed from the other
view controllers. Users can add the artworks to their collections from here or create new one's.

class SearchUsersViewController --> View controller in which a user can search for other users (by their e-mail) and see 
their collections.

class SearchResultTableViewController --> Table view controller showing the search results obtained via the Rijksmuseum 
API: https://www.rijksmuseum.nl/nl/api

class SearchViewController --> View controller in which users can search the collection of the Rijksmuseum via the API.

class CollectionInfoTableViewController --> Table view controller showing the individual artworks in a collection, 
also showing their images.

class CollectionsTableViewController --> Table view controller displaying collections.

Most important functions:

Retrieve() (Comes in different forms) --> Uses a json decoder to decode the information retrieved from the API and puts this in the relevant structs
which are then used to fill the cells/labels/imageViews.

startObserving() (Comes in different forms) --> By using a reference based on the relevant user and collection/artwork data this function collects the
relevant data from the firebase database, putting it in the relevant structs.

load_Image() --> Loads image into imageView by using the URL supplied by the API or Firebase.

Search() --> Function that creates the URL for the GET request which is used by Retrieve()

## Challenges

The most tricky part during the first part of developing this app, was working with the Rijksmuseum API. The API returns
a LOT of data in different forms and creating appropriate structs to save this data in turned out to be rather difficult and
error prone. Having gone through this struggle I now feel very confident about working with JSON data and how to handle it 
within Swift. The changes I've had to make because of this were a lot, mostly deleting and adding lines of code to the structs in which
the data was saved.
A major change that happened because of this, was that decision to make the app Dutch, as the there were too many cases
in which the english version of the API didn't have the same data resulting in less overall information supplied by the app.

The second big challenge came with Firebase. Since the data returned by the rijksmuseum API wasn't always consistend, 
saving it in Firebase was very error prone, especially once you started retrieving this data. Especially where images where
concerned I had to change quite a few things before I could succesfuly store them in all cases without resulting in errors. 
Having struggled so much with this though I can safely say I now feel a lot more confident using databases and have a much 
better understanding of their structure. 

The third challenge was with Asynchronous requests and certain code being performed in the background of the app.
Because my app has to retrieve and pass data for almost every view controller and segue (in most cases from the internet)
it would need to have finished getting this data before moving on or executing the next piece of code in some cases to prevent
errors and empty table views.
This took me a very long time to figure out and lead me to initially write a lot of unnecessary and overly complicated code although
most of my problems could be fixed by using a DispatchQueue. However, this did give me a very good understanding of Asynchronous
requests and the way in which a lot of apps function.

The final challenge was making the app look the way I had envisioned and creating a nice lay out. While doing this
a lot of the weaknesses and issues in my code came back to bite me (mostly where images were concerned) and really
made me realise the importance of clearly and logically written code. Another important lesson I learned here (shout out
to constraints) is the importance of patience and staying calm and counting to 10. 

# Changes

I have pretty much sticked to everything in my design document, except that instead of saving "recent users" I have 
decided to just save their collections instead. This seemed more logical given the theme and point of the App. 










## Week 2 day 1

Worked on loading in the JSON data via a decoder. Uploaded swift files for all the different "structs" in the data obtained from the API. 
Also worked on setting up the Firebase database, Registration function basics work but signing in signing out is still buggy.

## Week 2 day 2

Made the functions to prepare data obtained via the API and send it to the next view controller. 
Changed my swift files to obtain/save different and extra data which is more convenient than the previous structs.
Created a function which allows users to search through the collection.
Attempted to make the segue between the search results and detail view controllers work properly.

Issues that need to be fixed: 
Not all artworks have labels, so different data needs to be obtained so details can be shown for all artworks.
Need to figure out how to make sure all data is retrieved before other lines of code are executed.

## Week 2 day 3

Changed the data that is requested and it now properly appears in the detail view controller.
"Add to collection" button works, saving the artwork to the user collection in Firebase.
Still have to work on creating some sort of dispatch queue to make sure code is executed in correct order so the data is properly transfered from 1 view controller to another.

Signing out still doesn't work properly.




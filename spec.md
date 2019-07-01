# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database - The classes for models for my app and the tables for my database inherit from ActiveRecord and use methods built into it to store information entered by users of the app in the database.
- [x] Include more than one model class (e.g. User, Post, Category) - I have a User model class and a Reservation model class.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts) - My User has_many Reservations.
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User) - My Reservation belongs_to a User.
- [x] Include user accounts with unique login attribute (username or email) - Users create an account using both a username and email address.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - My Reservations controller has routes for all the basic CRUD operations.
- [x] Ensure that users can't modify content created by other users - I tested to make sure Users can see all Reservations, but only edit or delete those of their own creation.
- [x] Include user input validations - Basic HTML makes sure the User enters anything at all and methods in the controller routes test that the input is valid.
- [x] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new) - Flash messages display for all of the common invalid inputs or actions.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits - I have a number of Git commits, but a lot of them have been lost between different respositories.  I had to switch to the Lubuntu setup to work on the previous few lessons because the Learn IDE crashed frequently and prevented me from making steady progress.  When I quit Virtual Box after coding, sometimes the Git repository would have an error and I could not connect to it, forcing me to start a new respository and copy over what I had already done.  The latter portion of my commits should be more consistent because they came after I resolved that issue.
- [x] Your commit messages are meaningful - I wrote commit messages that described the work I was doing in as meaningful and succint way as I could.
- [x] You made the changes in a commit that relate to the commit message - I wrote messages that reflected what I was doing at the time I submitted them.
- [x] You don't include changes in a commit that aren't related to the commit message - Because of the issue I described above, some files may have been committed when I had to start a new respository and may not have messages relevant to what is in them, but I tried to rectify that with the latter portion of my commits.
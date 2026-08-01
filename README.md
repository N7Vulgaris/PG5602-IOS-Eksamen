# Ratatouille

## Description
A native iOS mobile application build with Swift and SwiftUI. Allows the user retrieve a list of food recipes from an API. The recipes can be viewed, added to favorites, archived and deleted.

## Technologies
The application was developed using **Swift** and **SwiftUI**.  
**CoreData** was utilized for storing recipes in a local database in the app.

## How to run
- Open the Ratatouille project in Xcode
- Press the play button in the top right of the file explorer:

<img width="390" height="207" alt="Screenshot 2026-08-01 at 22 14 24" src="https://github.com/user-attachments/assets/738c9d5b-3dee-4c92-b0a2-ad5134d4dc15" /> <br>
- The application will launch with the Simulator app (iPhone 17 Pro)

## Database
The application uses a local database to store recipes that the user has added to their favorites/archive.  
The structure of the database is as follows:
- area: String
- category: String
- imageUrl: String
- ingredient: String
- instructions: String
- isFavorited: Boolean
- name: String

## Usage
The application has three main screens:  
- **Mine oppskrifter (My recipes):** Shows a list of all the recipes the user has favorited / added to the database. By default the database is empty. The user may click on each recipe for more info, instructions or to edit the recipe. The user may edit the country of origin, category (dinner, breakfast etc.) or ingredients. The recipe will then be updated in the database. The user may also move the recipe to an archive, where it may be deleted from the database.  
<img width="301.5" height="655.5" alt="Simulator Screenshot - iPhone 17 - 2026-03-19 at 17 36 14" src="https://github.com/user-attachments/assets/23616e01-2875-4f94-9e9c-e50060dbcd96" /> <br>
- **Søk (Search):** Lets the user search for recipes. The recipes are fetched from the **"TheMealDB.com"** API. The user may search for recipes based on the recipe name, country, category or ingredient. The user can also click on a recipe to see further detail, and save the recipe to favorites. The recipe is then saved to the database.  
<img width="301.5" height="655.5" alt="Simulator Screenshot - iPhone 17 - 2026-03-19 at 17 38 34" src="https://github.com/user-attachments/assets/5822a552-6ce1-4e34-95df-9881ad3ef250" /> <br>
- **Innstillinger (Settings):** Here the user may delete and add new countries, categories or ingredients. These can then be used when editing recipes on the My Recipes page.
When a recipe is "deleted" on the My Recipes page, it isn't immedietly deleted. It is instead added to an archive. The user can view the archive on the Settings page, and may choose to either restore the recipe or permanently delete it.

# Ratatouille

## Description
This project is my delivery for an iOS Programming exam in November-December 2023 as a part of my Bachelor's degree. The purpose of the exam was to develop a mobile app that retrieves a list of food recipes from an API. The user is then able view the recipes, add them to a database of their favorites, archive them and delete them.

## Technologies
The application was developed using **Swift** and **SwiftUI**.  
**CoreData** was utilized for storing recipes in a local database in the app.

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

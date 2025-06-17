# MarketplaceDemo
MarketplaceDemo is a simple iOS app demonstrating common features like fetching and displaying posts, showing post details with comments and images, and creating new posts via a REST API. It is built using UIKit and follows an MVC architecture pattern.

## Screenshots

<img src="https://github.com/user-attachments/assets/415d19ae-8417-4c27-a237-80d64c72fa16" alt="app_home" width="200"/>
<img src="https://github.com/user-attachments/assets/547a238b-680c-40e8-a679-cd3004a2685b" alt="app_home" width="200"/>
<img src="https://github.com/user-attachments/assets/7b75e7c2-749c-4a25-9596-99ab6eb7ca00" alt="app_home" width="200"/>

## Features

<h5>Posts List Screen</h5>
<ul>
  <li>Fetches and displays a paginated list of posts.</li>
  <li>Tapping a post navigates to the Post Details screen.</li>
  <li>Includes a button to navigate to the Create Post screen.</li>
</ul>

<h5>Post Details Screen</h5>
<ul>
  <li>Fetches and displays detailed information about the selected post.</li>
  <li>Displays the first three comments related to the post.</li>
  <li>Shows a placeholder image.</li>
</ul>

<h5>Create Post Screen</h5>
<ul>
  <li>Allows users to enter a new post’s title and body.</li>
  <li>Submits the new post via a POST request.</li>
</ul>

## Architecture
<ul>
  <li>MVC: The project follows the Model-View-Controller design pattern.</li>
  <li>NetworkManager: A singleton class that handles all network operations.</li>
  <li>Pagination: Fetches posts in batches with a fixed limit of 20 items per request.</li>
  <li>Async/Await: asynchronous network calls.</li>
  <li>Unit Tests: Contains basic tests coverage.</li>
</ul>

## Get Started
<ol>
  <li>Clone the repository: <code>git clone https://github.com/sducic/MarketplaceDemo.git</code>
  </li>
  <li>Open <code>MarketplaceDemo.xcodeproj</code> in Xcode.</li>
  <li>Build and run the app on a simulator or device.</li>
</ol>

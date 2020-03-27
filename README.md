# Interprio
Group Project - README Template
===

# Interprio

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
An app that allows users to upload images and make thier own story from that one image.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category: Art/Creativity**
- **Mobile: IOS**
- **Story: Allows users to upload images and create thier stories from that one image**
- **Market: Anyone who enjoys character art and stories**
- **Habit: Users can enjoy stories**
- **Scope: Posting character art and making story comments **

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Login
* Register
* Stream
* Creation
* Profile

**Optional Nice-to-have Stories**

* Flipping (like a page) Genres/Topics
* Chat Room
* Story voting system
* 

### 2. Screen Archetypes

* Login
    * User can login
* Register
    * User can register a new account
* Stream
    * User can "scroll" down 
* Creation
    * User can upload an image
* Profile
    * User can showcase thier uploads


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Profile
* Stream
* Creation
* Profile

**Flow Navigation** (Screen to Screen)

* Login
   * Stream
* Register
   * Stream
* Stream 
    * Profile
    * Creation
* Profile
    * Stream
## Wireframes
https://www.figma.com/file/hh5T3gI96g9CTW45m2tjcv/Interpo?node-id=0%3A1
![enter image description here](https://raw.githubusercontent.com/Interprio/Interprio/master/CaptureInterprio.PNG)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
**User**
| Property | Type | Description |
| --------   | --------    | -------- |
| UserID      | String       | An ID that identifies user.|
| Email | String | The users email.|
|Password | String | string that will allow user to sign in|
|Profile_Picture | File | Users profile picture.|
|Date_Created | DateTime | Date user created account.|

**Book**
| Property | Type | Description |
| --------   | --------    | -------- |
| ThreadID       | String        |  An ID that indentifies the book (thread).    |
| UserID       | String        | An ID that identifies the user.     |
| Picture       | File        | Cover picture of a Book. (thread)     |
| Likes       | Number        | Number of upvotes on a comment.     |
| Dislikes       | Number        | Number of downvotes on a comment.    |
| Report       | Number        | User can report bad post.    |
| Comment       | String        | A string that is posted inside of a book.     |
| Date_Created       | Date Time        | Date and time the book was created.     |

**Posts**
| Property | Type | Description |
| --------   | --------    | -------- |
| ThreadID      | String        | An ID that identifies the book. (Thread)     |
| PostID       | String      | Identifies the post object.     |
| UserID       | String       | Identifies who made the post.    |
| Comment       | String       | Comment add to post.    |
| Report       | Number        | User can make a report of a bad post.     |
| Likes_Count       | Number        | Total of likes.     |
| Date_Created       | DateTime        | Date the post was created.     |
| Post_Picture       | File        | The image attached to the post.    |

**Comments**
| Property | Type | Description |
| --------   | --------    | -------- |
| CommentID      | Number        | An ID that identifies the comment from the user     |
| UserID       | String       | Identifies User.     |
| Likes | Number | users who likes the comment. |
| Dislikes       | Number        | users who dislike the comment.     |
| Date_Created       | DateTime        | date the comment was posted.    |

**Post_Likes**
| Property | Type | Description |
| --------   | --------    | -------- |
| PostID      | Number       | An ID for the post from the user.     |
| UserID       | String        | An ID for the post from user.     |
| TypeOfLikes       | String        | Identifies whether it is a like or dislike.     |
| CategoryOfLike       | String     | Identifies where the like was made. Ex: Book like, Post Like, Comment Like     |

**Dislikes**
| Property | Type | Description |
| --------   | --------    | -------- |
| PostID      | String        | Identifies which post was disliked.    |
| UserID  | String       | Identifies user who disliked.     |
| TypeOfDislikes      | String        | Identifies where the dislike was made.    |

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

# PHOTO-MAG
In work environments where different people need to work with photos eg. for PR or marketing purposes, sustaining an overview of the availble photos is difficult. This holds especially true when these people work in different locations with different filesystems, intranets, external harddrives and the like. The issues of such a fragmented situation were fueled even more with the introduction of the General Data Protection Regulation of the the European Union (called DSGVO in Germany). Photos contain very sensitive data and different rights are attached them. The personal rights of the people that are shown on the picture as well as the copy rights of the photographer. This situation represents the framework for this project.

Requirements:
    - Centralized approach
    - Always availble
    - Secure access
    - User management
    - Possbility to upload and download multiple large files at once
    - Preview uploaded photos
    - Possibilty to upload, save and show coresponding permssions after the originals on paper have beed signed and scanned
    - Save, edit and show metadata such as
        - Name of photo
        - When was the photo shot?
        - Who shot it?
        - When has it be deleted? (in this case one year after last usage)
        - What does the permission allow?
        - What channels/media are the photos allowed to be used on?
    - Taging and filtering
    - Search functionality
    - Flexible folder/file system to cover different needs

Implmentation
    - Web App
    - Ruby (2.7.0) on Rails (6.0.3.3)
    - File uploads and management with ActiveStorage of Rails
    - AWS S3 for file storage with aws-sdk-s3 (1.80.0)
    - PostgreSQL 10.14
    - bootstrap (4.0.0.alpha6)
    - Previews/thumbnails with ActiveStorage, image_processing (~> 1.2) and mini_magick (4.10.1)
    - Downloads via ZIP straming using zip_tricks (5.3.1)
    - User management with devise (4.7.2)
    - Folder structure with acts_as_tree (2.9.1)
    - Tagging via many-to-many table structure
    - Filtering utilizing tagging structure
    - Search functionality with flexible conditionals on model level for tags, photographers and year of shooting

The project can been found in its latest version on https://photo-mag.herokuapp.com

Roadmap:

Technical
    - Improve eager loading / optimize database access
    - Simplify permission table structure
    - Optimize responsivness of navigation bar
    - Enhance search functionality or implement external one
    - Make URLs more speaking


Features
    - Breadcrumbs
    - Implement user rights concept
    - Allow users to create own tags
    - Allow certain users to create photographers with corresponding contact data
    - Allow users to add and edit meta data to permissions
    - Rediesgn / make more appealing show page of photos 




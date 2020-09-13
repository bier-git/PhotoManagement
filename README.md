# PHOTO-MAG
In work environments where different people need to work with photos eg. for PR or marketing purposes, sustaining an overview of the availble photos is difficult. This holds especially true when these people work in different locations with different filesystems, intranets, external harddrives and the like. The issues of such a fragmented situation were fueled even more with the introduction of the General Data Protection Regulation of the the European Union (called DSGVO in Germany). Photos contain very sensitive data and different rights are attached them. The personal rights of the people that are shown on the picture as well as the copy rights of the photographer. This situation represents the framework for this project.

<h2> Requirements </h2>
    <ul>
        <li>Centralized approach </li>
        <li>Always availble </li>
        <li>Secure access </li>
        <li>User management </li>
        <li>Possbility to upload and download multiple large files at once </li>
        <li>Preview uploaded photos </li>
        <li>Possibilty to upload, save and show coresponding permssions after the originals on paper have beed signed and scanned </li>
        <li>Save, edit and show metadata such as </li>
            <ul>
                <li> Name of photo </li>
                <li> When was the photo shot? </li>
                <li> Who shot it? </li>
                <li> When has it be deleted? (in this case one year after last usage) </li>
                <li> What does the permission allow? </li>
                <li> What channels/media are the photos allowed to be used on? </li>
            </ul>
        <li> Taging and filtering </li>
        <li> Search functionality </li>
        <li> Flexible folder/file system to cover different needs </li>
    </ul>

<h2> Implementation </h2>
    <ul>
        <li> Web App </li>
        <li> Ruby (2.7.0) on Rails (6.0.3.3) </li>
        <li> File uploads and management with ActiveStorage of Rails </li>
        <li> AWS S3 for file storage with aws-sdk-s3 (1.80.0) </li>
        <li> PostgreSQL 10.14 </li>
        <li> bootstrap (4.0.0.alpha6) </li>
        <li> Previews/thumbnails with ActiveStorage, image_processing (~> 1.2) and mini_magick (4.10.1) </li>
        <li> Downloads via ZIP straming using zip_tricks (5.3.1) </li>
        <li> User management with devise (4.7.2) </li>
        <li> Folder structure with acts_as_tree (2.9.1) </li>
        <li> Tagging via many-to-many table structure </li>
        <li> Filtering utilizing tagging structure </li>
        <li> Search functionality with flexible conditionals on model level for tags, photographers and year of shooting </li>
    </ul>
    
<p><b>The project can been found in its latest version on https://photo-mag.herokuapp.com </p></b>

<h2> Roadmap </h2>

<h3> Technical </h3>
    <ul>
        <li> Improve eager loading / optimize database access </li>
        <li> Simplify permission table structure </li>
        <li> Optimize responsivness of navigation bar </li>
        <li> Enhance search functionality or implement external one </li>
        <li> Make URLs more speaking </li>
    </ul>


<h3> Features </h3>
    <ul>
        <li> Breadcrumbs  </li>
        <li> Implement user rights concept </li>
        <li> Allow users to create own tags </li>
        <li> Allow certain users to create photographers with corresponding contact data </li>
        <li> Allow users to add and edit meta data to permissions </li>
        <li> Redesign / make more appealing show page of photos  </li>
    </ul>




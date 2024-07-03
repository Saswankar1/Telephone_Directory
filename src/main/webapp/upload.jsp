<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Form</title>
    <link rel="stylesheet" type="text/css" href="styles/upload1.css">
</head>
<body>
    <img src="images/AGCL.png" class="logo"> 
    <div class="container">
        <div class="header">
            <img src="images/paper-plane.png" alt="Paper Plane" width="70">
            <div>Send us your Files!</div>
        </div>
        <form id="uploadForm" action="FileUploadServlet" method="post" enctype="multipart/form-data">
            <label for="fileType">Select your file type</label>
            <select id="fileType" name="fileType" required>
                <option value="">Please Select</option>
                <option value="pdf">PDF</option>
                <option value="doc">DOC</option>
            </select>
            <label for="category">Select the category</label>
            <select id="category" name="category" required>
                <option value="">Please Select</option>
                <option value="sap">SAP User Manual</option>
                <option value="policies">AGCL Common Policies</option>
            </select>
            <label for="file">Upload your files here</label>
            <div class="file-upload">
                <label for="file" class="custom-file-upload">
                    <img class="upload_img" src="upload-3-xl.webp" alt="">
                    BROWSE
                </label>
                <input type="file" id="file" name="file" required>
            </div>
            <button type="submit">UPLOAD</button>
        </form>
    </div>

    <script>
        // File input change event
        const fileInput = document.getElementById('file');
        const customFileUpload = document.querySelector('.custom-file-upload');
        fileInput.addEventListener('change', function() {
            if (fileInput.files.length > 0) {
                customFileUpload.style.backgroundColor = '#fff';  
                customFileUpload.style.color = '#383368';  
                customFileUpload.textContent = 'File selected'; 
            } else {
                customFileUpload.style.backgroundColor = '#383368';  
                customFileUpload.style.color = 'white';  
                customFileUpload.textContent = 'Click to upload';  
            }
        });
    </script>
</body>
</html>

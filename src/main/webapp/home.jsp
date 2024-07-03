<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Upload Landing Page</title>
    <style>
  		@import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");
    
    	
		body {
		    font-family: "Montserrat", sans-serif;
		    margin: 0;
		    padding: 0;
		}
		
		:root {
		    --pc: #8f5a98; 
		}
		
		header {
		    background-color: #fff;
		    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
		    padding: 20px 0;
		}
		
		.container {
		    width: 80%;
		    margin: 0 auto;
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		
		.logo img {
		    width: 80%;
		}
		
		.header-btn {
		    display: flex;
		    gap: 20px;
		}
		
		nav ul {
		    list-style: none;
		    display: flex;
		    margin: 0;
		    padding: 0;
		}
		
		nav ul li {
		    margin-left: 20px;
		}
		
		nav ul li a {
		    text-decoration: none;
		    color: black;
		    font-weight: bold;
		}
		
		nav ul li a:hover {
		    color: var(--pc);
		}
		
		.btn-signin {
		    background-color: var(--pc);
		    color: white;
		    padding: 15px 25px;
		    border-radius: 5px;
		    text-decoration: none;
		    font-weight: bold;
		    border: 2px solid var(--pc);
		    transition: 1s ease;
		}
		
		.btn-signin:hover {
		    background: none;
		    border: 2px solid var(--pc);
		    color: var(--pc);
		}
		
		.hero {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		    padding: 50px 0;
		}
		
		.hero .container {
		    display: flex;
		    justify-content: space-between;
		    align-items: center;
		}
		
		.hero-content {
		    max-width: 500px;
		}
		
		.hero-content h1 {
		    font-size: 5.5em;
		    margin-bottom: 20px;
		    margin-top: 10px;
		}
		
		.hero-content h1 span {
		    color: var(--pc);
		}
		
		.hero-content p {
		    margin-bottom: 30px;
		    line-height: 1.6;
		    color: #666;
		}
		
		.btn-readmore {
		    background-color: none;
		    color: var(--pc);
		    padding: 15px 25px;
		    border-radius: 5px;
		    text-decoration: none;
		    font-weight: bold;
		    border: 2px solid var(--pc);
		    transition: 1s ease;
		}
		
		.btn-readmore:hover {
		    background-color: var(--pc);
		    color: white;
		}
		
		.hero-image img {
		    width: 500px;
		}
		
		.btn-container {
		    display: flex;
		    gap: 30px; /* Add space between buttons */
		    margin-top: 20px; 
		}
		
		@media (max-width: 768px) {
		    .container {
		        flex-direction: column;
		        text-align: center;
		    }
		
		    .header-btn {
		        align-items: center;
		        gap: 10px; /* Add space between buttons */
		    }
		    .btn-container{
		    	flex-direction: column;
		    }
		
		    .btn-signin {
		        margin-left: 0;
		    }
		
		    .hero {
		        flex-direction: column;
		    }
		
		    .hero-content h1 {
		        font-size: 2.5em;
		    }
		
		    .hero-image img {
		        width: 100%;
		        margin-top: 20px;
		    }
		
		    .hero-content p {
		        margin-bottom: 50px;
		    }
		}
		
		@media (max-width: 480px) {
		    .hero-content h1 {
		        font-size: 2em;
		    }
		
		    .hero-content p {
		        margin-bottom: 50px;
		    }
		
		    .btn-readmore, .btn-signin {
		        padding: 10px;
		        font-size: 0.9em;
		    }
		
		    .btn-readmore {
		        margin-bottom: 10px;
		    }
		}

    	
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 400px;
            text-align: center;
            border-radius: 10px;
            font-family: "Montserrat", sans-serif;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .modal-header {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .modal-body {
            font-size: 18px;
            margin-bottom: 20px;
        }

        .modal-footer {
            text-align: center;
        }

        .modal-footer button {
            background-color: #8f5a98;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            border: 2px solid var(--pc);
            transition: 1s ease;
        }
        .modal-footer button:hover {
            background: none;
            color: #8f5a98;
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="logo">
                <img alt="" src="images/AGCL.png">
            </div>
            <div class="header-btn">
                <a href="upload.jsp" class="btn-signin">Upload</a>
                <a href="#" class="btn-signin">DELETE</a>
            </div>
        </div>
    </header>
    <main>
        <div class="hero">
            <div class="container">
                <div class="hero-content">
                    <h1>File <span>Upload</span></h1>
                    <p>Welcome to our File Upload Application. This platform allows you to easily upload, manage, and share your documents securely to our AGCL Portal. Our system supports various file types including PDFs, DOCs, and DOCXs. Start uploading your files.</p>
                   <p>Want to check the files? Check it below!</p>
                    <div class="btn-container">
                        <a href="sap.jsp" class="btn-readmore">User Manual</a>
                        <a href="Cp.jsp" class="btn-signin">Common Policies</a>
                    </div>
                </div>
                <div class="hero-image">
                    <img src="images/ils.png" alt="Upload Illustration">
                </div>
            </div>
        </div>
    </main>

    <!-- The Modal -->
    <div id="successModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div class="modal-header">Success</div>
            <div class="modal-body">File uploaded successfully!</div>
            <div class="modal-footer">
                <button onclick="closeModal()">Close</button>
            </div>
        </div>
    </div>

    <script>
        // Function to close the modal
        function closeModal() {
            document.getElementById('successModal').style.display = 'none';
        }

        // Show the modal if the status is success
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('status') === 'success') {
                document.getElementById('successModal').style.display = 'block';
            }
        }

        // Get the modal
        var modal = document.getElementById('successModal');

        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName('close')[0];

        // When the user clicks on <span> (x), close the modal
        span.onclick = function() {
            modal.style.display = 'none';
        }

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</body>
</html>

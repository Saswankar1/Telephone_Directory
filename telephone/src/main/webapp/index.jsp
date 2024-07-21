<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Telephone Landing Page</title>
    <style>
  		@import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");
    
    	
		body {
		    font-family: "Montserrat", sans-serif;
		    margin: 0;
		    padding: 0;
		}
		
		:root {
		    --pc: #0096da; 
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
		    font-size: 5.5rem;
		    margin-bottom: 10px;
		    margin-top: 10px;
		}
		
		.hero-content h1 span {
		    color: var(--pc);
		    font-size: 3rem;
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

    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="logo">
                <img alt="" src="Images/AGCL.png">
            </div>
        </div>
    </header>
    <main>
        <div class="hero">
            <div class="container">
                <div class="hero-content">
                   <h1>AGCL <span>Telephone Register</span></h1>
                <p>Welcome to our Telephone record management Application. This platform allows you to check all the important records of our officials, if you want to edit the contacts, login as admin.</p>
                <p>Want to check the records? Check it below!</p>
                <div class="btn-container">
                    <a href="ShowRecordsServlet" class="btn-readmore">Telephone Register</a>
                    <a href="admin_login.jsp" class="btn-readmore">Admin Login</a>
                </div>
                </div>
                <div class="hero-image">
                    <img src="Images/contact.jpg" alt="Upload Illustration">
                </div>
            </div>
        </div>
    </main>
</body>
</html>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap');
        
        body {
            font-family: 'Montserrat', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }
        
        :root {
		    --pc: #0096da; 
		}
		
        
        .login-card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            width: 600px;
            max-width: 100%;
        }
        
        .login-card-header {
            background-color: var(--pc);
            padding: 50px;
            text-align: center;
            color: #fff;
            font-size: 24px;
            font-weight: 700;
        }
        
        .login-card-body {
            padding: 20px;
        }
        
        .login-card-body label {
            display: block;
            margin-bottom: 10px;
            font-weight: 700;
        }
        
        .login-card-body input[type="email"],
        .login-card-body input[type="password"] {
            width: 96%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        .login-card-body input[type="submit"] {
            background-color: var(--pc);
		    color: white;
		    padding: 15px 25px;
		    border-radius: 5px;
		    text-decoration: none;
		    font-weight: bold;
		    width:100%;
		    margin-top: 20px;
		    margin-bottom: 30px;
		    border: 2px solid var(--pc);
		    transition: 1s ease;
        }
        
        .login-card-body input[type="submit"]:hover {
             background: none;
		    border: 2px solid var(--pc);
		    color: var(--pc);
        }
    </style>
    <script>
        function showLoginFailedPopup() {
            alert("Invalid email or password. Please try again.");
        }

        function showPasswordSentPopup() {
            alert("Password has been sent to your email.");
        }
    </script>
</head>
<body>
    <div class="login-card">
        <div class="login-card-header">
            LOGIN
        </div>
        <div class="login-card-body">
            <form action="AdminLoginServlet" method="post">
                <label for="email">Email ID</label>
                <input type="email" id="email" name="email" required>
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
                <input type="submit" value="Login">
            </form>
           <!--  <a href="forgot_password.jsp">Forgot Password?</a>-->
            <% 
                Boolean loginFailed = (Boolean) request.getAttribute("loginFailed");
                if (loginFailed != null && loginFailed) {
            %>
                <script>
                    showLoginFailedPopup();
                </script>
            <% 
                }
                Boolean passwordSent = (Boolean) request.getAttribute("passwordSent");
                if (passwordSent != null && passwordSent) {
            %>
                <script>
                    showPasswordSentPopup();
                </script>
            <% 
                }
            %>
        </div>
    </div>
</body>
</html>

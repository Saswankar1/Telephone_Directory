<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>
    <link rel="stylesheet" type="text/css" href="styles/sign.css">
</head>
<body>
    <div class="container">
    	<div class="logo">
                <img alt="" src="images/AGCL.png">
        </div>
        <div class="signup-form">
        	<div class="header">
	            <h3>SIGNUP</h3>
        	</div>
            <form action="signup" method="post">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" required>
                <label for="email">Email</label>
                <input type="text" id="email" name="email" required>
                <label for="passwd">Password</label>
                <input type="password" id="passwd" name="passwd" required>
                <button type="submit">Signup</button>
            </form>
        </div>
    </div>
</body>
</html>

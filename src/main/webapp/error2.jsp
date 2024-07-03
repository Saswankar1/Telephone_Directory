<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR</title>
<style>
		@import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");
        body {
            font-family: "Montserrat", sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
</style>
</head>
<body>
	<h1>We are having some errors in our server. Pls Try Again !</h1>
	<p>${param.message}</p>
    <a href="upload.jsp" class="btn-readmore">UPLOAD FILES</a>
</body>
</html>
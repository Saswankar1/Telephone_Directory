<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Record</title>
    <style>
         @import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");

        :root {
            --pc: #0096da; 
        }

        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 20px;
            background-color: #f0f0f0;
            font-family: "Montserrat";
        }
        .form-container {
            background: #fff;
            padding: 15px; /* Reduced padding */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 40%; /* Reduced width */
        }
        .form-container form {
            display: flex;
            flex-direction: column;
            text-align: left;
            padding: 20px;
        }
        .form-container input,
        .form-container select,
        .form-container button,
        .form-container a, 
        .form-container select {
            margin: 10px 0; 
            padding: 8px; 
            font-size: 14px; 
            font-family: "Montserrat";
        }
        .form-container input {
            width: 97%;
        }

        .form-container select {
            width: 100%;
            border: 1px solid #ccc;
        }

        .form-container button {
            background: none;
            border: 1px solid var(--pc);
            color: var(--pc);
            transition: 1s ease;
        }
        .form-container button:hover {
            background-color: var(--pc);
            color: white;
        }
        .form-container a {
            text-decoration: none;
            color: white;
            background-color: var(--pc);
            transition: 1s ease;
            border: 1px solid var(--pc);
            text-align: center;
        }
        .form-container a:hover {
            color: var(--pc);
            background: none;
        }
        h2{
        	margin-top: 80px;
        }
    </style>
</head>
<body>
	<div class="form-container">
    <h2>Add New Record</h2>
    <form id="addRecordForm" action="AddRecordServlet" method="post">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br>

        <label for="phone_number">Phone Number:</label>
        <input type="text" id="phone_number" name="phone_number" required><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>

        <label for="post">Designation:</label>
        <select id="post" name="post" required>
        	<option value="N/A">N/A</option>
            <c:forEach var="designation" items="${designations}">
                <option value="${designation}">${designation}</option>
            </c:forEach>
        </select><br>

        <label for="department">Department:</label>
        <select id="department" name="department" required>
        	<option value="N/A">N/A</option>
            <c:forEach var="department" items="${departments}">
                <option value="${department}">${department}</option>
            </c:forEach>
        </select><br>

        <label for="telecom">Telecom:</label>
        <input type="text" id="telecom" name="telecom" required><br>

        <label for="employee_id">Employee ID:</label>
        <input type="text" id="employee_id" name="employee_id" required><br>

        <button type="submit">Add</button>
        <button type="button" onclick="window.history.back()">Cancel</button>
    </form>

	</div>
   
    
</body>
</html>

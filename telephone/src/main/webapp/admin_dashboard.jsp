<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");

        body {
            font-family: "Montserrat", sans-serif;
            margin: 0;
            padding: 20px;
        }

        #popupForm, #confirmationModal {
            display: none;
            position: fixed;
            left: 50%;
            top: 50%;
            transform: translate(-50%, -50%);
            border: 1px solid #888;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            z-index: 1000;
            width: 30%;
        }
	
        form {
            padding: 30px;
        }

        input, select {
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            width: 94%;
            font-size: 16px;
        }

        label {
            margin-bottom: 10px;
            font-weight: 700;
        }

        #popupBackground, #confirmationBackground {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 500;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 0;
        }

        .logo img {
            width: 60%;
        }

        .header-buttons {
            display: flex;
            align-items: center;
        }

        .header-buttons a, .header-buttons button{
        	font-family: "Montserrat", sans-serif;
            margin-left: 20px;
            padding: 10px 20px;
            border-radius: 5px;
            border: 1.2px solid #0096da;
            color: white;
            background-color: #0096da;
            cursor: pointer;
            text-decoration: none;
            transition: 1s ease;
        }

        .header-buttons button {
            font-size: 16px;
            font-family: "Montserrat", sans-serif;
        }

        .header-buttons a:hover, .header-buttons button:hover, .btn:hover{
            color: #0096da;
            background: none;
        }
        .body_btn {
		    margin-top: 50px;
		    display: grid;
		    grid-template-columns: 1fr 1fr;
		    gap: 30px;
		    width: 80%;
    		margin: auto;
		}
			

		.body_btn a, .body_btn button {
			margin-top: 30px;
		    font-family: "Montserrat", sans-serif;
		    font-size: 20px;
		    padding: 100px 20px;
		    border-radius: 5px;
		    font-weight: bold;
		    color: white;
		    cursor: pointer;
		    text-decoration: none;
		    transition: 1s ease;
		    text-align: center;
		}
		.btn{
			background-color: #0096da;
			border: 3px solid #0096da;
		}
		.button{
			background-color: #17B169;
			border: 3px solid #17B169;
		}
		.btn1{
			background-color: #FF0000;
			border: 3px solid #FF0000;
		}
		.btn1:hover{
			 color: #FF0000;
            background: none;
		}
		.button:hover{
			 color: #17B169;
            background: none;
		}
        h1 {
            margin-right: 10px;
        }

        .btn-container {
            display: flex;
            margin-top: 20px;
            justify-content: center;
            align-items: center;
        }

        .btn-container button {
            width: 40%;
            padding: 10px;
            margin-left: 20px;
            border-radius: 5px;
            border: 1.2px solid #0096da;
            color: white;
            background-color: #0096da;
            cursor: pointer;
            transition: 1s ease;
        }

        .btn-container button:hover {
            color: #0096da;
            background: none;
        }

        #successMessage {
            display: none;
            position: fixed;
            left: 50%;
            top: 20%;
            transform: translate(-50%, -50%);
            border: 1px solid #888;
            padding: 20px;
            background-color: #dff0d8;
            color: #3c763d;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }
        #active-records-table{
        	margin-bottom: 60px;
        }

    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <img alt="" src="Images/AGCL.png">
        </div>
        <h1>Admin Dashboard</h1>
        <div class="header-buttons">
            <a href="logout">Logout</a>
        </div>
    </div>

	<div class="body_btn">
		<a href="delete1.jsp" class="btn1">Edit/Delete Records</a>
		<button onclick="window.location.href='FetchDataServlet?action=add'" class="button">Add Record</button>
		<a href="AdminDashboardServlet?view=active" class="btn">Show Active Records</a>
    	<a href="AdminDashboardServlet?view=inactive" class="btn">Show Inactive Records</a>
		
	</div>
	

    <!-- Hidden iframe for form submission -->
    <iframe id="hiddenIframe" name="hiddenIframe" style="display:none;" onload="iframeLoadHandler()"></iframe>

    <!-- Success message -->
    <div id="successMessage">Record updated successfully!</div>

    <script>
        function togglePopupForm() {
            var form = document.getElementById("popupForm");
            var background = document.getElementById("popupBackground");
            if (form.style.display === "none") {
                form.style.display = "block";
                background.style.display = "block";
            } else {
                form.style.display = "none";
                background.style.display = "none";
            }
        }

        function toggleConfirmationModal() {
            var modal = document.getElementById("confirmationModal");
            var background = document.getElementById("confirmationBackground");
            if (modal.style.display === "none") {
                modal.style.display = "block";
                background.style.display = "block";
            } else {
                modal.style.display = "none";
                background.style.display = "none";
            }
        }

        function confirmDelete(recordId) {
            toggleConfirmationModal();
            document.getElementById('confirmDeleteButton').onclick = function() {
                window.location.href = 'DeleteRecordServlet?id=' + recordId;
            }
        }

        function iframeLoadHandler() {
            var iframe = document.getElementById('hiddenIframe');
            var iframeDocument = iframe.contentDocument || iframe.contentWindow.document;
            var responseText = iframeDocument.body.textContent || iframeDocument.body.innerText;

            if (responseText.trim() === 'success') {
                togglePopupForm();
                showSuccessMessage('Record added successfully!');
                fetchRecords();
            } else if (responseText.trim() === 'error') {
                alert('An error occurred while adding the record.');
            }
        }

        function showSuccessMessage(message) {
            var successMessage = document.getElementById('successMessage');
            successMessage.textContent = message;
            successMessage.style.display = 'block';
            setTimeout(() => {
                successMessage.style.display = 'none';
            }, 3000);
        }

        function fetchRecords() {
            fetch('AdminDashboardServlet')
                .then(response => response.text())
                .then(data => {
                    const tempElement = document.createElement('div');
                    tempElement.innerHTML = data;

                    // Update the active records table
                    const newActiveTableBody = tempElement.querySelector('#active-records-table tbody');
                    if (newActiveTableBody) {
                        document.querySelector('#active-records-table tbody').innerHTML = newActiveTableBody.innerHTML;
                    }

                    // Update the inactive records table
                    const newInactiveTableBody = tempElement.querySelector('#inactive-records-table tbody');
                    if (newInactiveTableBody) {
                        document.querySelector('#inactive-records-table tbody').innerHTML = newInactiveTableBody.innerHTML;
                    }
                });
        }

        window.onload = function() {
            fetchRecords();

            const urlParams = new URLSearchParams(window.location.search);
            if (urlParams.has('addSuccess')) {
                showSuccessMessage('Record added successfully!');
            }
            if (urlParams.has('updateSuccess')) {
                showSuccessMessage('Record updated successfully!');
            }
            if (urlParams.has('deleteSuccess')) {
                showSuccessMessage('Record deleted successfully!');
            }
        }
    </script>
</body>
</html>

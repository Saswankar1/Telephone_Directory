<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Delete/Edit records</title>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
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

        .header-buttons a, .header-buttons button {
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

        .header-buttons a:hover, .header-buttons button:hover {
            color: #0096da;
            background: none;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        tbody a {
            display: inline-block;
            padding: 8px 16px;
            margin: 4px;
            border-radius: 5px;
            border: 1.2px solid #0096da;
            color: white;
            background-color: #0096da;
            text-decoration: none;
            transition: 0.3s ease;
        }

        tbody a:hover {
            color: #0096da;
            background: none;
            border-color: #0096da;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #ddd;
            padding-bottom: 20px;
            padding-top: 20px;
        }

        tr:hover {
            background-color: #f5f5f5;
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

        #active-records-table, #inactive-records-table {
            margin-bottom: 60px;
        }
         .dataTables_wrapper .dataTables_filter {
            text-align: left;
        }
		td{
			text-align: center;
		}
		th{
			text-align: center;
		}
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <img alt="" src="Images/AGCL.png">
        </div>
        <h1>Edit/Delete Records</h1>
        <div class="header-buttons">
            <a href="admin_dashboard.jsp">Go Back</a>
        </div>
    </div>

    <h2>Active Records</h2>
    <div id="active-records-table">
        <table id="activeRecordsTable" class="display">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                    <th>Designation</th>
                    <th>Department</th>
                    <th>Telecom</th>
                    <th>Employee Id</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <h2>Inactive Records</h2>
    <div id="inactive-records-table">
        <table id="inactiveRecordsTable" class="display">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                    <th>Designation</th>
                    <th>Department</th>
                    <th>Telecom</th>
                    <th>Employee Id</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

    <!-- Confirmation modal -->
    <div id="confirmationBackground" onclick="toggleConfirmationModal()"></div>
    <div id="confirmationModal">
        <h2>Confirm Deletion</h2>
        <p>Are you sure you want to delete this record?</p>
        <div class="btn-container">
            <button id="confirmDeleteButton">Yes</button>
            <button onclick="toggleConfirmationModal()">No</button>
        </div>
    </div>

    <!-- Hidden iframe for form submission -->
    <iframe id="hiddenIframe" name="hiddenIframe" style="display:none;" onload="iframeLoadHandler()"></iframe>

    <!-- Success message -->
    <div id="successMessage">Record updated successfully!</div>
    

    <script type="text/javascript">
        $(document).ready(function() {
            fetchRecords();

            $('#activeRecordsTable').DataTable();
            $('#inactiveRecordsTable').DataTable();
        });

        function fetchRecords() {
            $.ajax({
                url: 'deleteDashboard',
                method: 'GET',
                success: function(data) {
                    console.log(data); // Log the JSON response
                    var activeRecords = data.activeRecords;
                    var inactiveRecords = data.inactiveRecords;

                    var activeTable = $('#activeRecordsTable').DataTable();
                    var inactiveTable = $('#inactiveRecordsTable').DataTable();

                    activeTable.clear();
                    inactiveTable.clear();

                    activeRecords.forEach(function(record) {
                        activeTable.row.add([
                            record.id,
                            record.name,
                            record.phoneNumber,
                            record.email,
                            record.post,
                            record.department,
                            record.telecom,
                            record.employeeId,
                            record.status,
                            '<a href="EditRecordServlet?id=' + record.id + '">Edit</a> ' +
                            '<a href="javascript:confirmDelete(' + record.id + ')">Delete</a>'
                        ]).draw();
                    });

                    inactiveRecords.forEach(function(record) {
                        inactiveTable.row.add([
                            record.id,
                            record.name,
                            record.phoneNumber,
                            record.email,
                            record.post,
                            record.department,
                            record.telecom,
                            record.employeeId,
                            record.status,
                            '<a href="EditRecordServlet?id=' + record.id + '">Edit</a> '
                        ]).draw();
                    });
                },

                error: function() {
                    alert('Failed to fetch records.');
                }
            });
        }

        function confirmDelete(recordId) {
            toggleConfirmationModal();
            document.getElementById('confirmDeleteButton').onclick = function() {
                window.location.href = 'DeleteRecordServlet?id=' + recordId;
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
    </script>
</body>
</html>

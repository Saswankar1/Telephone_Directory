<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inactive Records</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/buttons/2.1.1/css/buttons.dataTables.min.css">
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/2.1.1/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/2.1.1/js/buttons.html5.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/buttons/2.1.1/js/buttons.print.min.js"></script>
    <style>
        @import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");

        body {
            font-family: "Montserrat", sans-serif;
            margin: 0;
            padding: 20px;
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

        .dataTables_wrapper .dataTables_filter {
            text-align: left;
        }

        label {
            margin-bottom: 10px;
            font-weight: 700;
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

        .header-buttons a, .header-buttons button, .body_btn a, .body_btn button, .btn-signin{
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

        .header-buttons a:hover, .header-buttons button:hover, .body_btn a:hover, .body_btn button:hover, .btn-signin:hover{
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
        #inactive-records-table{
            margin-bottom: 60px;
        }
         .filter{
        	margin-left:20%;
        }
        .filter select{
        	width: 50%
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <img alt="" src="Images/AGCL.png">
        </div>
        <h1>Inactive Records</h1>
        <div class="header-buttons">
            <a href="admin_dashboard.jsp">Go Back</a>
        </div>
    </div>

    <table id="inactive-records-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Employee Id</th>
                <th>Phone Number</th>
                <th>Email</th>
                <th>Designation</th>
                <th>Department</th>
                <th>Telecom</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="record" items="${inactiveRecords}">
                <tr>
                    <td>${record.id}</td>
                    <td>${record.name}</td>
                    <td>${record.employeeId}</td>
                    <td>${record.phoneNumber}</td>
                    <td>${record.email}</td>
                    <td>${record.post}</td>
                    <td>${record.department}</td>
                    <td>${record.telecom}</td>
                    <td>${record.status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <script type="text/javascript">
        $(document).ready(function() {
            var table = $('#inactive-records-table').DataTable({
                "paging": true,
                "ordering": true,
                "searching": true,
                "dom": 'Bfrtip',
                "buttons": [
                    'copy', 'csv', 'excel', 'pdf', 'print'
                ]
            });
        });
    </script>
</body>
</html>

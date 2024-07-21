<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="servlets.Record" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Telephone Records</title>
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
            padding: 50px;
            background-color: #f4f4f4;
        }

        :root {
            --pc: #0096da; 
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
            margin-bottom: 20px;
        }

        .logo img {
            width: 70%;
        }

        h1 {
            margin-right: 50px;
        }

        .btn-signin {
            background-color: var(--pc);
            color: white;
            padding: 15px 25px;
            border-radius: 5px;
            text-decoration: none;
            border: 2px solid var(--pc);
            transition: 1s ease;
        }

        .btn-signin:hover {
            background: none;
            border: 2px solid var(--pc);
            color: var(--pc);
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: 100%;
            margin-top: 80px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: var(--pc);
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

        td {
            border-bottom: 1px solid #ddd;
        }
        .filter{
            margin-bottom: 20px;
        }
        .filter select{
            margin-left: 10px; 
            margin-right: 10px;
            padding: 8px; 
            font-size: 14px; 
            font-family: "Montserrat";
        }
        .filter button{
            padding: 10px 30px;
            font-family: "Montserrat";
        }
        .dataTables_wrapper .dataTables_filter input {
            margin-bottom: 20px;
            margin-left: 10px; 
            margin-right: 10px;
            padding: 8px; 
            font-size: 14px; 
            font-family: "Montserrat";
            border: 1px solid #0c0c0c;
            background-color: #ffffff;
        }
        .dataTables_wrapper .dataTables_paginate .paginate_button.current{
             margin-top: 5px;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="logo">
            <img alt="" src="Images/AGCL.png">
        </div>
        <h1>Telephone Phonebook</h1>
        <a href="index.jsp" class="btn-signin">Go back</a>
    </div>
    <div class="container">
        <table id="telephoneRecordsTable" class="display">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Employee Id</th>
                    <th>Designation</th>
                    <th>Department</th>
                    <th>Intercom</th> <!-- Add Telecom column -->
                    <th>Phone Number</th>
                    <th>Official Email</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="record" items="${records}">
                    <tr>
                        <td>${record.id}</td>
                        <td>${record.name}</td>
                        <td>${record.employeeId}</td>
                        <td>${record.post}</td>
                        <td>${record.department}</td>
                        <td>${record.telecom}</td> <!-- Add Telecom field -->
                        <td>${record.phoneNumber}</td>
                        <td>${record.email}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#telephoneRecordsTable').DataTable({
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

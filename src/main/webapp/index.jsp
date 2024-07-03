<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="styles/sign.css">
    <style>
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
            border: 2px solid #8f5a98;
            transition: 1s ease;
        }
        
        .modal-footer button:hover {
            background: none;
            color: #8f5a98;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">
            <img alt="" src="images/AGCL.png">
        </div>
        <div class="login-form">
            <div class="header">
                <h3>LOGIN</h3>
            </div>
            <form action="login" method="post">
                <label for="email">Email ID</label>
                <input type="text" id="email" name="email" required>
                <label for="passwd">Password</label>
                <input type="password" id="passwd" name="passwd" required>
                <button type="submit">Login</button>
            </form>
        </div>
    </div>

    <!-- The Modal -->
    <div id="loginFailedModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div class="modal-header">Login Failed</div>
            <div class="modal-body">
                <% 
                    String status = request.getParameter("status");
                    if ("invalidEmail".equals(status)) {
                        out.println("Invalid email format. Please try again.");
                    } else {
                        out.println("Login not successful. Please try again.");
                    }
                %>
            </div>
            <div class="modal-footer">
                <button onclick="closeModal()">Close</button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Function to close the modal
        function closeModal() {
            document.getElementById('loginFailedModal').style.display = 'none';
        }

        // Show the modal if login failed or email is invalid
        <% if ("failed".equals(status) || "invalidEmail".equals(status)) { %>
            document.getElementById('loginFailedModal').style.display = 'block';
        <% } %>

        // Get the modal
        var modal = document.getElementById('loginFailedModal');

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

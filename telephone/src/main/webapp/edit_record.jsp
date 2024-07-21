<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Record</title>
    <link rel="stylesheet" href="styles.css">
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
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Edit Record</h1>
        <form action="UpdateRecordServlet" method="post">
            ID: <input type="text" name="id" value="${id}" readonly>
            Employee ID: <input type="text" name="employee_id" value="${employee_id}" readonly>
            Name: <input type="text" name="name" value="${name}" readonly>
            Phone Number: <input type="text" name="phone_number" value="${phone_number}" required>
            Email: <input type="text" name="email" value="${email}" required>
            Designation: 
            <select name="post" required>
            	 	<option value="N/A" ${post == 'N/A' ? 'selected' : ''}>N/A</option>
				    <option value="Engineer" ${post == 'Engineer' ? 'selected' : ''}>Engineer</option>
				    <option value="Clerk" ${post == 'Clerk' ? 'selected' : ''}>Clerk</option>
				    <option value="Manager" ${post == 'Manager' ? 'selected' : ''}>Manager</option>
				    <option value="Deputy Manager" ${post == 'Deputy Manager' ? 'selected' : ''}>Deputy Manager</option>
				    <option value="Chairman" ${post == 'Chairman' ? 'selected' : ''}>Chairman</option>
				    <option value="Sr. Manager" ${post == 'Sr. Manager' ? 'selected' : ''}>Sr. Manager</option>
				    <option value="Staff room – Ground Floor" ${post == 'Staff room – Ground Floor' ? 'selected' : ''}>Staff room – Ground Floor</option>
				    <option value="Supervisor" ${post == 'Supervisor' ? 'selected' : ''}>Supervisor</option>
				    <option value="Staff room – First Floor" ${post == 'Staff room – First Floor' ? 'selected' : ''}>Staff room – First Floor</option>
				    <option value="Accounts Conference room – Second Floor" ${post == 'Accounts Conference room – Second Floor' ? 'selected' : ''}>Accounts Conference room – Second Floor</option>
				    <option value="Staff Room" ${post == 'Staff Room' ? 'selected' : ''}>Staff Room</option>
				    <option value="GM" ${post == 'GM' ? 'selected' : ''}>GM</option>
				    <option value="Assistant Manager" ${post == 'Assistant Manager' ? 'selected' : ''}>Assistant Manager</option>
				    <option value="Sr. Manager & CFO" ${post == 'Sr. Manager & CFO' ? 'selected' : ''}>Sr. Manager & CFO</option>
				    <option value="DGM" ${post == 'DGM' ? 'selected' : ''}>DGM</option>
				    <option value="Chief Manager" ${post == 'Chief Manager' ? 'selected' : ''}>Chief Manager</option>
				    <option value="Assistant Manager (Systems)" ${post == 'Assistant Manager (Systems)' ? 'selected' : ''}>Assistant Manager (Systems)</option>
				    <option value="Assistant Supervisor" ${post == 'Assistant Supervisor' ? 'selected' : ''}>Assistant Supervisor</option>
				    <option value="Engineer (CP)" ${post == 'Engineer (CP)' ? 'selected' : ''}>Engineer (CP)</option>
				    <option value="Executive Officer to MD" ${post == 'Executive Officer to MD' ? 'selected' : ''}>Executive Officer to MD</option>
				    <option value="Officer" ${post == 'Officer' ? 'selected' : ''}>Officer</option>
				    <option value="Managing Director/ Director, DNPL" ${post == 'Managing Director/ Director, DNPL' ? 'selected' : ''}>Managing Director/ Director, DNPL</option>
				    <option value="Pharmacist" ${post == 'Pharmacist' ? 'selected' : ''}>Pharmacist</option>		            	            
           	</select>
            Department: 
            <select name="department" required>	
			    <option value="N/A" ${department == 'N/A' ? 'selected' : ''}>N/A</option>
			    <option value="Projects & Planning" ${department == 'Projects & Planning' ? 'selected' : ''}>Projects & Planning</option>
			    <option value="Business Development (BD)" ${department == 'Business Development (BD)' ? 'selected' : ''}>Business Development (BD)</option>
			    <option value="Pipeline" ${department == 'Pipeline' ? 'selected' : ''}>Pipeline</option>
			    <option value="Cathodic Protection (CP)" ${department == 'Cathodic Protection (CP)' ? 'selected' : ''}>Cathodic Protection (CP)</option>
			    <option value="Instrumentation & TGG" ${department == 'Instrumentation & TGG' ? 'selected' : ''}>Instrumentation & TGG</option>
			    <option value="SCADA" ${department == 'SCADA' ? 'selected' : ''}>SCADA</option>
			    <option value="Compressor" ${department == 'Compressor' ? 'selected' : ''}>Compressor</option>
			    <option value="City Gas Distribution (CGD)" ${department == 'City Gas Distribution (CGD)' ? 'selected' : ''}>City Gas Distribution (CGD)</option>
			    <option value="Retail Business & Coordination" ${department == 'Retail Business & Coordination' ? 'selected' : ''}>Retail Business & Coordination</option>
			    <option value="Health Safety & Environment (HSE)" ${department == 'Health Safety & Environment (HSE)' ? 'selected' : ''}>Health Safety & Environment (HSE)</option>
			    <option value="Electrical" ${department == 'Electrical' ? 'selected' : ''}>Electrical</option>
			    <option value="Civil" ${department == 'Civil' ? 'selected' : ''}>Civil</option>
			    <option value="Contracts & Procurements (C&P)" ${department == 'Contracts & Procurements (C&P)' ? 'selected' : ''}>Contracts & Procurements (C&P)</option>
			    <option value="Human Resource and Admin (HR&A)" ${department == 'Human Resource and Admin (HR&A)' ? 'selected' : ''}>Human Resource and Admin (HR&A)</option>
			    <option value="Land" ${department == 'Land' ? 'selected' : ''}>Land</option>
			    <option value="Medical" ${department == 'Medical' ? 'selected' : ''}>Medical</option>
			    <option value="Transport" ${department == 'Transport' ? 'selected' : ''}>Transport</option>
			    <option value="Company Secretary" ${department == 'Company Secretary' ? 'selected' : ''}>Company Secretary</option>
			    <option value="Security & Vigilance" ${department == 'Security & Vigilance' ? 'selected' : ''}>Security & Vigilance</option>
			    <option value="Finance & Accounts (F&A)" ${department == 'Finance & Accounts (F&A)' ? 'selected' : ''}>Finance & Accounts (F&A)</option>
			    <option value="F&A" ${department == 'F&A' ? 'selected' : ''}>F&A</option>
			    <option value="Retail Business & Coordination" ${department == 'Retail Business & Coordination' ? 'selected' : ''}>Retail Business & Coordination</option>
			    <option value="Electrical" ${department == 'Electrical' ? 'selected' : ''}>Electrical</option>
			    <option value="Instrumentation, SCADA, Compressor" ${department == 'Instrumentation, SCADA, Compressor' ? 'selected' : ''}>Instrumentation, SCADA, Compressor</option>
			    <option value="SCADA" ${department == 'SCADA' ? 'selected' : ''}>SCADA</option>
			    <option value="Medical" ${department == 'Medical' ? 'selected' : ''}>Medical</option>
			    <option value="HR&A (Transport)" ${department == 'HR&A (Transport)' ? 'selected' : ''}>HR&A (Transport)</option>
			    <option value="HSE & Compliance" ${department == 'HSE & Compliance' ? 'selected' : ''}>HSE & Compliance</option>
			    <option value="HR&A (Land)" ${department == 'HR&A (Land)' ? 'selected' : ''}>HR&A (Land)</option>
			    <option value="Compressor" ${department == 'Compressor' ? 'selected' : ''}>Compressor</option>
			    <option value="HSE" ${department == 'HSE' ? 'selected' : ''}>HSE</option>
			    <option value="HR&A" ${department == 'HR&A' ? 'selected' : ''}>HR&A</option>
			    <option value="Civil" ${department == 'Civil' ? 'selected' : ''}>Civil</option>
			    <option value="MD Secretariat" ${department == 'MD Secretariat' ? 'selected' : ''}>MD Secretariat</option>
			    <option value="N/A" ${department == 'N/A' ? 'selected' : ''}>N/A</option>
			    <option value="C&P" ${department == 'C&P' ? 'selected' : ''}>C&P</option>
			    <option value="HR&A (Legal)" ${department == 'HR&A (Legal)' ? 'selected' : ''}>HR&A (Legal)</option>
			    <option value="Managing Director/ Director" ${department == 'Managing Director/ Director' ? 'selected' : ''}>Managing Director/ Director</option>
			    <option value="BD & Projects" ${department == 'BD & Projects' ? 'selected' : ''}>BD & Projects</option>
			    <option value="IT" ${department == 'IT' ? 'selected' : ''}>IT</option>
			    <option value="Security & Vigilance" ${department == 'Security & Vigilance' ? 'selected' : ''}>Security & Vigilance</option>
			    <option value="CGD" ${department == 'CGD' ? 'selected' : ''}>CGD</option>
			    <option value="Pipeline" ${department == 'Pipeline' ? 'selected' : ''}>Pipeline</option>
			    <option value="Instrumentation" ${department == 'Instrumentation' ? 'selected' : ''}>Instrumentation</option>
			    <option value="Compressor (Workshop)" ${department == 'Compressor (Workshop)' ? 'selected' : ''}>Compressor (Workshop)</option>
			</select>
            Status: 
            <select name="status">
                <option value="Active" ${status == 'Active' ? 'selected' : ''}>Active</option>
                <option value="Inactive" ${status == 'Inactive' ? 'selected' : ''}>Inactive</option>
            </select><br>
            Telecom: <input type="text" name="telecom" value="${telecom}" required>
            <button type="submit">Update</button>
            <a href="delete1.jsp">Cancel</a>
        </form>
    </div>
</body>
</html>

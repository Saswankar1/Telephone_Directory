<%@ page import="java.io.*" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Comparator" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AGCL Common Policies Files</title>
    <style>
    	@import url("https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap");
        body {
            font-family: "Montserrat", sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }
        h1 {
            text-align: center;
            color: #333;
        }
        ul {
            list-style-type: none;
            padding: 0;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        li {
            background-color: #fff;
            margin: 10px;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
            flex: 1 1 calc(50% - 40px); /* 50% width minus margins */
            box-sizing: border-box;
            text-align: center;
        }
        a {
            text-decoration: none;
            color: #8f5a98;
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline;
        }
        @media (max-width: 600px) {
            li {
                flex: 1 1 100%;
            }
        }
    </style>
</head>
<body>
    <h1>Common Policies Files</h1>
    <ul>
        <%
            Properties props = new Properties();
            try (InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties")) {
                props.load(input);
            } catch (IOException ex) {
                ex.printStackTrace();
            }
            String policiesUploadDir = props.getProperty("policies.upload.dir");
            File dir = new File(policiesUploadDir);
            if (dir.exists() && dir.isDirectory()) {
                File[] files = dir.listFiles();
                if (files != null) {
                    // Sort files alphabetically by name
                    Arrays.sort(files, Comparator.comparing(File::getName));

                    for (File file : files) {
                        if (file.isFile() && !file.getName().equals(".DS_Store") && !file.isHidden()) {
                            String fileName = file.getName();
                            String filePath = policiesUploadDir + "/" + fileName;
                            out.println("<li><a href='download?file=" + filePath + "' target='_blank'>" + fileName + "</a></li>");
                        }
                    }
                } else {
                    out.println("<li>No files found in the directory.</li>");
                }
            } else {
                out.println("<li>Directory does not exist.</li>");
            }
        %>
    </ul>
</body>
</html>

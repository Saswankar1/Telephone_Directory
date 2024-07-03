package FileUpload.servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.util.Properties;
import java.io.FileInputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/FileUploadServlet")
@MultipartConfig
public class FileUploadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static String UPLOAD_DIR;
    private static String SAP_UPLOAD_DIR;
    private static String POLICIES_UPLOAD_DIR;
    
    private static final int MAX_FILE_SIZE = 25 * 1024 * 1024; // 25 MB in bytes
    private static final Logger LOGGER = Logger.getLogger(FileUploadServlet.class.getName());

    // Load database connection parameters from properties file
    private Properties loadProperties() throws IOException {
        Properties properties = new Properties();
        String propertiesFilePath = getServletContext().getRealPath("/WEB-INF/config.properties");
        try (FileInputStream fis = new FileInputStream(propertiesFilePath)) {
            properties.load(fis);
        }
        return properties;
    }

    @Override
    public void init() throws ServletException {
        try {
            Properties properties = loadProperties();
            UPLOAD_DIR = properties.getProperty("upload.dir");
            SAP_UPLOAD_DIR = properties.getProperty("sap.upload.dir");
            POLICIES_UPLOAD_DIR = properties.getProperty("policies.upload.dir");
        } catch (IOException e) {
            throw new ServletException("Failed to load properties file", e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get additional form fields
        String fileType = request.getParameter("fileType");
        String category = request.getParameter("category");

        // Determine the upload directory based on the selected category
        String uploadFilePath;
        if ("sap".equals(category)) {
            uploadFilePath = SAP_UPLOAD_DIR;
        } else if ("policies".equals(category)) {
            uploadFilePath = POLICIES_UPLOAD_DIR;
        } else {
            uploadFilePath = UPLOAD_DIR;
        }

        // Create the upload directory if it does not exist
        File uploadDir = new File(uploadFilePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Get the file part from the request
        Part filePart = request.getPart("file");

        // Get the file name and size
        String fileName = getFileName(filePart);
        long fileSize = filePart.getSize();

        // Check if the file size exceeds the limit
        if (fileSize > MAX_FILE_SIZE) {
            response.sendRedirect("error3.jsp");
            return;
        }

        // Check if the file is a PDF or DOC
        if (!fileName.endsWith(".pdf") && !fileName.endsWith(".doc") && !fileName.endsWith(".docx")) {
            response.sendRedirect("error.jsp");
            return;
        }

        // Check if the file already exists
        File file = new File(uploadFilePath + File.separator + fileName);
        if (file.exists()) {
            // Move existing file to archive
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
            String timestamp = sdf.format(new Date());
            File archiveFile = new File(uploadFilePath + File.separator + "archives" + File.separator + fileName + "_" + timestamp);
            File archiveDir = new File(uploadFilePath + File.separator + "archives");
            if (!archiveDir.exists()) {
                archiveDir.mkdirs();
            }
            Files.move(file.toPath(), archiveFile.toPath());
        }

        // Write the new file to the specified directory
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath());
        }

        // Insert file details into the database only if the file is new
        if (!file.exists()) {
            try {
                Properties properties = loadProperties();
                String dbUrl = properties.getProperty("db.url");
                String dbUser = properties.getProperty("db.user");
                String dbPassword = properties.getProperty("db.password");
                String insertStatement = properties.getProperty("db.insert");

                Class.forName("org.postgresql.Driver");
                try (Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword)) {
                    PreparedStatement ps = con.prepareStatement(insertStatement);
                    ps.setString(1, fileName);
                    ps.setString(2, fileType);
                    ps.setInt(3, (int) request.getSession().getAttribute("userId")); // Retrieve userId from session
                    ps.setLong(4, fileSize);

                    LOGGER.log(Level.INFO, "Executing SQL: {0}", ps.toString());
                    int rowsInserted = ps.executeUpdate();
                    if (rowsInserted > 0) {
                        LOGGER.log(Level.INFO, "File details inserted successfully.");
                    } else {
                        LOGGER.log(Level.SEVERE, "Failed to insert file details.");
                        response.sendRedirect("error2.jsp");
                        return;
                    }
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQL Exception: ", e);
                    response.sendRedirect("error2.jsp");
                    return;
                }
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "Exception: ", e);
                response.sendRedirect("error2.jsp");
                return;
            }
        }

        // Redirect to home.jsp with success parameter
        response.sendRedirect("home.jsp?status=success");
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }
}

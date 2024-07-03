package FileUpload.servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/download")
public class FileDownloadServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filePath = request.getParameter("file");
        
        // Validate file path to prevent directory traversal
        if (filePath == null || !filePath.startsWith("/Users/raj/Desktop/uploads/")) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid file path");
            return;
        }

        File downloadFile = new File(filePath);

        if (downloadFile.exists() && !downloadFile.isDirectory()) {
            FileInputStream inStream = new FileInputStream(downloadFile);

            // Set appropriate content type
            String contentType = getServletContext().getMimeType(filePath);
            if (contentType == null) {
                contentType = "application/octet-stream";
            }
            response.setContentType(contentType);
            response.setContentLength((int) downloadFile.length());

            // No need to force download, allow browser to handle
            // Set content disposition to inline to open in browser
            String headerKey = "Content-Disposition";
            String headerValue = "inline; filename=\"" + downloadFile.getName() + "\"";
            response.setHeader(headerKey, headerValue);

            // Obtain the response's output stream
            OutputStream outStream = response.getOutputStream();

            byte[] buffer = new byte[4096];
            int bytesRead = -1;

            // Write bytes from the input stream into the output stream
            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }

            inStream.close();
            outStream.close();
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found or it's a directory.");
        }
    }
}

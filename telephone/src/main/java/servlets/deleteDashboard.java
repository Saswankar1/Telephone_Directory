package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import java.util.logging.Logger;

@WebServlet("/deleteDashboard")
public class deleteDashboard extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(deleteDashboard.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin_login.jsp");
            return;
        }

        Properties props = new Properties();
        try (InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties")) {
            if (input == null) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to find config.properties");
                return;
            }
            props.load(input);
        } catch (IOException ex) {
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading config.properties");
            return;
        }

        String dbUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.user");
        String dbPassword = props.getProperty("db.password");
        String dbQueryActive = props.getProperty("db.query.active");
        String dbQueryInactive = props.getProperty("db.query.inactive");

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Fetch active records
            PreparedStatement psActive = con.prepareStatement(dbQueryActive);
            ResultSet rsActive = psActive.executeQuery();
            List<Record> activeRecords = new ArrayList<>();
            while (rsActive.next()) {
                Record record = new Record();
                record.setId(rsActive.getInt("id"));
                record.setName(rsActive.getString("name"));
                record.setPhoneNumber(rsActive.getString("phone_number"));
                record.setEmail(rsActive.getString("email"));
                record.setStatus(rsActive.getString("status"));
                record.setPost(rsActive.getString("post"));
                record.setDepartment(rsActive.getString("department"));
                record.setTelecom(rsActive.getInt("telecom"));
                record.setEmployeeId(rsActive.getString("employee_id"));
                activeRecords.add(record);
            }

            // Fetch inactive records
            PreparedStatement psInactive = con.prepareStatement(dbQueryInactive);
            ResultSet rsInactive = psInactive.executeQuery();
            List<Record> inactiveRecords = new ArrayList<>();
            while (rsInactive.next()) {
                Record record = new Record();
                record.setId(rsInactive.getInt("id"));
                record.setName(rsInactive.getString("name"));
                record.setPhoneNumber(rsInactive.getString("phone_number"));
                record.setEmail(rsInactive.getString("email"));
                record.setStatus(rsInactive.getString("status"));
                record.setPost(rsInactive.getString("post"));
                record.setDepartment(rsInactive.getString("department"));
                record.setTelecom(rsInactive.getInt("telecom"));
                record.setEmployeeId(rsInactive.getString("employee_id"));
                inactiveRecords.add(record);
            }

            con.close();

            // Create response object
            ResponseData responseData = new ResponseData(activeRecords, inactiveRecords);

            // Convert response data to JSON
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(responseData);

            // Log the JSON response
            logger.info("JSON Response: " + jsonResponse);

            // Send JSON response
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print(jsonResponse);
            out.flush();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    private class ResponseData {
        @SuppressWarnings("unused")
		List<Record> activeRecords;
        @SuppressWarnings("unused")
		List<Record> inactiveRecords;

        public ResponseData(List<Record> activeRecords, List<Record> inactiveRecords) {
            this.activeRecords = activeRecords;
            this.inactiveRecords = inactiveRecords;
        }
    }
}

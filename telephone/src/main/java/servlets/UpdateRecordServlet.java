package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateRecordServlet")
public class UpdateRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String employeeId = request.getParameter("employee_id");
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phone_number");
        String email = request.getParameter("email");
        String status = request.getParameter("status");
        String post = request.getParameter("post");
        String department = request.getParameter("department");
        int telecom = Integer.parseInt(request.getParameter("telecom"));

        Properties props = new Properties();
        try (InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties")) {
            if (input == null) {
                response.getWriter().println("Sorry, unable to find config.properties");
                return;
            }
            props.load(input);
        } catch (IOException ex) {
            ex.printStackTrace();
            response.getWriter().println("Error loading config.properties");
            return;
        }

        String dbUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.user");
        String dbPassword = props.getProperty("db.password");
        String dbQueryUpdateRecord = props.getProperty("db.query.update_record");

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Print the constructed SQL query for debugging
            System.out.println("SQL Query: " + dbQueryUpdateRecord);

            PreparedStatement ps = con.prepareStatement(dbQueryUpdateRecord);
            ps.setString(1, name);
            ps.setString(2, phoneNumber);
            ps.setString(3, email);
            ps.setString(4, status);
            ps.setString(5, post);
            ps.setString(6, department);
            ps.setInt(7, telecom);
            ps.setString(8, employeeId);
            ps.setInt(9, id);

            int updateCount = ps.executeUpdate();

            con.close();

            if (updateCount > 0) {
                response.sendRedirect("admin_dashboard.jsp?updateSuccess=true");
            } else {
                response.getWriter().println("No record found with the provided ID.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}

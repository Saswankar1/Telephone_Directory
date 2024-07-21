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

@WebServlet("/AddRecordServlet")
public class AddRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");

        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phone_number");
        String email = request.getParameter("email");
        String post = request.getParameter("post");
        String department = request.getParameter("department");
        String telecomStr = request.getParameter("telecom");
        Integer telecom = (telecomStr != null && !telecomStr.isEmpty()) ? Integer.parseInt(telecomStr) : null;
        String employeeId = request.getParameter("employee_id");

        Properties props = new Properties();
        try (InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties")) {
            if (input == null) {
                response.getWriter().println("error");
                return;
            }
            props.load(input);
        } catch (IOException ex) {
            ex.printStackTrace();
            response.getWriter().println("error");
            return;
        }

        String dbUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.user");
        String dbPassword = props.getProperty("db.password");
        String dbQueryInsert = props.getProperty("db.query.insert");

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            PreparedStatement ps = con.prepareStatement(dbQueryInsert);
            ps.setString(1, name);
            ps.setString(2, phoneNumber);
            ps.setString(3, email);
            ps.setString(4, post);
            ps.setString(5, department);
            if (telecom != null) {
                ps.setInt(6, telecom);
            } else {
                ps.setNull(6, java.sql.Types.INTEGER);
            }
            ps.setString(7, employeeId);
            ps.executeUpdate();

            con.close();
            
            // Redirect to the admin dashboard with a success message
            response.sendRedirect("admin_dashboard.jsp?addSuccess=true");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("error");
        }
    }
}

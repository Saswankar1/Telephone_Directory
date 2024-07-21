package servlets;

import java.io.IOException;
import java.io.InputStream;
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

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminId") == null) {
            response.sendRedirect("admin_login.jsp");
            return;
        }

        String view = request.getParameter("view");
        String department = request.getParameter("department");

        Properties props = new Properties();
        try (InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties")) {
            if (input == null) {
                request.setAttribute("errorMessage", "Sorry, unable to find config.properties");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            props.load(input);
        } catch (IOException ex) {
            ex.printStackTrace();
        }

        String dbUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.user");
        String dbPassword = props.getProperty("db.password");
        String dbQueryActive = props.getProperty("db.query.active");
        String dbQueryFilteredActive = props.getProperty("db.query.filteredActive");
        String dbQueryInactive = props.getProperty("db.query.inactive");
        String dbQueryFilteredInactive = props.getProperty("db.query.filteredInactive");

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            if ("active".equals(view)) {
                PreparedStatement psActive;
                if (department == null || department.isEmpty()) {
                    psActive = con.prepareStatement(dbQueryActive);
                } else {
                    psActive = con.prepareStatement(dbQueryFilteredActive);
                    psActive.setString(1, department);
                }
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
                request.setAttribute("activeRecords", activeRecords);
                request.getRequestDispatcher("show_active_records.jsp").forward(request, response);
            } else if ("inactive".equals(view)) {
                PreparedStatement psInactive;
                if (department == null || department.isEmpty()) {
                    psInactive = con.prepareStatement(dbQueryInactive);
                } else {
                    psInactive = con.prepareStatement(dbQueryFilteredInactive);
                    psInactive.setString(1, department);
                }
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
                request.setAttribute("inactiveRecords", inactiveRecords);
                request.getRequestDispatcher("show_inactive_records.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

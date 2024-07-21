package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditRecordServlet")
public class EditRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Properties props = new Properties();
        try (InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties")) {
            if (input == null) {
                response.getWriter().println("Sorry, unable to find config.properties");
                return;
            }
            props.load(input);
        } catch (IOException ex) {
            ex.printStackTrace();
        }

        String dbUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.user");
        String dbPassword = props.getProperty("db.password");
        String dbQuerySelectById = props.getProperty("db.query.select_by_id");

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            PreparedStatement ps = con.prepareStatement(dbQuerySelectById);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("id", rs.getInt("id"));
                request.setAttribute("employee_id", rs.getString("employee_id"));
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("phone_number", rs.getString("phone_number"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("status", rs.getString("status"));
                request.setAttribute("post", rs.getString("post"));
                request.setAttribute("department", rs.getString("department"));
                request.setAttribute("telecom", rs.getInt("telecom"));

                RequestDispatcher rd = request.getRequestDispatcher("edit_record.jsp");
                rd.forward(request, response);
            } else {
                response.getWriter().println("Record not found. <a href='admin_dashboard.jsp'>Go back</a>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

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
        }

        String dbUrl = props.getProperty("db.url");
        String dbUser = props.getProperty("db.user");
        String dbPassword = props.getProperty("db.password");
        String dbQueryUpdateRecord = props.getProperty("db.query.update_record");

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            PreparedStatement ps = con.prepareStatement(dbQueryUpdateRecord);
            ps.setString(1, employeeId);
            ps.setString(2, name);
            ps.setString(3, phoneNumber);
            ps.setString(4, email);
            ps.setString(5, status);
            ps.setString(6, post);
            ps.setString(7, department);
            ps.setInt(8, telecom);
            ps.setInt(9, id);
            ps.executeUpdate();

            response.sendRedirect("AdminDashboardServlet?updateSuccess=true");
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("error");
        }
    }
}

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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ShowRecordsServlet")
public class ShowRecordsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        String d1 = props.getProperty("d1");
        String d2 = props.getProperty("d2");

        String selectedDepartment = request.getParameter("department");

        List<Record> records = new ArrayList<>();

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            PreparedStatement ps;
            if (selectedDepartment != null && !selectedDepartment.isEmpty()) {
                ps = con.prepareStatement(d1);
                ps.setString(1, selectedDepartment);
            } else {
                ps = con.prepareStatement(d2);
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Record record = new Record();
                record.setId(rs.getInt("id"));
                record.setName(rs.getString("name"));
                record.setPhoneNumber(rs.getString("phone_number"));
                record.setEmail(rs.getString("email"));
                record.setPost(rs.getString("post"));
                record.setDepartment(rs.getString("department"));
                record.setTelecom(rs.getInt("telecom")); // Add telecom field
                record.setEmployeeId(rs.getString("employee_id"));
                records.add(record);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("records", records);
        RequestDispatcher rd = request.getRequestDispatcher("show_records.jsp");
        rd.forward(request, response);
    }
}

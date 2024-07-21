package servlets;

//import java.io.FileInputStream;
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

@WebServlet("/FetchDataServlet")
public class FetchDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Properties configProps = new Properties();

    @Override
    public void init() throws ServletException {
        super.init();
        try (InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties")) {
            if (input == null) {
                System.out.println("Sorry, unable to find config.properties");
                return;
            }
            configProps.load(input);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String> departments = new ArrayList<>();
        List<String> designations = new ArrayList<>();
        
        // Database connection and data fetching logic
        try {
            Class.forName("org.postgresql.Driver");
            Connection conn = DriverManager.getConnection(
                configProps.getProperty("db.url"),
                configProps.getProperty("db.user"),
                configProps.getProperty("db.password")
            );

            // Fetch departments
            PreparedStatement ps = conn.prepareStatement(configProps.getProperty("db.query.departments"));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                departments.add(rs.getString("department_name"));
            }

            // Fetch designations
            ps = conn.prepareStatement(configProps.getProperty("db.query.designations"));
            rs = ps.executeQuery();
            while (rs.next()) {
                designations.add(rs.getString("designation_name"));
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("departments", departments);
        request.setAttribute("designations", designations);

        // Determine which JSP to forward to based on request parameters
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            request.getRequestDispatcher("add_record.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
        }
    }
}

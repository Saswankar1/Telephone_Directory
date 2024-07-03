package FileUpload.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.io.FileInputStream;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Load database connection parameters from properties file
    private Properties loadProperties() throws IOException {
        Properties properties = new Properties();
        String propertiesFilePath = getServletContext().getRealPath("/WEB-INF/config.properties");
        try (FileInputStream fis = new FileInputStream(propertiesFilePath)) {
            properties.load(fis);
        }
        return properties;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String passwd = request.getParameter("passwd");

        // Validate email format
        if (!isValidEmail(email)) {
            response.sendRedirect("index.jsp?status=invalidEmail");
            return;
        }

        try {
            Properties properties = loadProperties();
            String dbUrl = properties.getProperty("db.url");
            String dbUser = properties.getProperty("db.user");
            String dbPassword = properties.getProperty("db.password");
            String selectStatement = properties.getProperty("db.select");

            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            PreparedStatement ps = con.prepareStatement(selectStatement);
            ps.setString(1, email);
            ps.setString(2, passwd);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.getSession().setAttribute("userId", rs.getInt("Uid"));
                response.sendRedirect("home.jsp");
            } else {
                response.sendRedirect("index.jsp?status=failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?status=failed");
        }
    }

    private boolean isValidEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        Pattern pattern = Pattern.compile(emailRegex);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }
}

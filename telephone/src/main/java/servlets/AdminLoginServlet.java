package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Properties loadProperties() throws IOException {
        Properties properties = new Properties();
        try (InputStream input = getServletContext().getResourceAsStream("/WEB-INF/config.properties")) {
            properties.load(input);
        }
        return properties;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Properties properties = loadProperties();
            String dbUrl = properties.getProperty("db.url");
            String dbUser = properties.getProperty("db.user");
            String dbPassword = properties.getProperty("db.password");
            String loginQuery = properties.getProperty("db.query.login");

            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            PreparedStatement ps = con.prepareStatement(loginQuery);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("adminId", rs.getInt("id"));
                session.setAttribute("adminName", rs.getString("name"));
                response.sendRedirect("admin_dashboard.jsp");
            } else {
                request.setAttribute("loginFailed", true);
                request.getRequestDispatcher("admin_login.jsp").forward(request, response);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
    }
}

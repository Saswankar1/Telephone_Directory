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

@WebServlet("/DeleteRecordServlet")
public class DeleteRecordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

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
        String dbQueryUpdateStatus = props.getProperty("db.query.update_status");

        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            PreparedStatement ps = con.prepareStatement(dbQueryUpdateStatus);
            ps.setInt(1, id);
            ps.executeUpdate();

            con.close();
            response.sendRedirect("admin_dashboard.jsp?deleteSuccess=true");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

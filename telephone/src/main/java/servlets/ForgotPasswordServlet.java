package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
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

        try {
            Properties properties = loadProperties();
            String dbUrl = properties.getProperty("db.url");
            String dbUser = properties.getProperty("db.user");
            String dbPassword = properties.getProperty("db.password");
            String emailUser = properties.getProperty("email.user");
            String emailPass = properties.getProperty("email.pass");
            String forgotPasswordQuery = properties.getProperty("db.query.forgot_password");

            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            PreparedStatement ps = con.prepareStatement(forgotPasswordQuery);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String password = rs.getString("password");

                // Send email
                String to = email;
                String from = properties.getProperty("email.from");
                String host = properties.getProperty("email.host");

                Properties emailProperties = System.getProperties();
                emailProperties.setProperty("mail.smtp.host", host);
                emailProperties.setProperty("mail.smtp.auth", "true");
                emailProperties.setProperty("mail.smtp.port", properties.getProperty("email.port"));
                emailProperties.setProperty("mail.smtp.starttls.enable", "true");

                Session mailSession = Session.getInstance(emailProperties, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(emailUser, emailPass);
                    }
                });

                try {
                    MimeMessage message = new MimeMessage(mailSession);
                    message.setFrom(new InternetAddress(from));
                    message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                    message.setSubject("Your Admin Password");
                    message.setText("Your password is: " + password);

                    Transport.send(message);
                } catch (MessagingException mex) {
                    mex.printStackTrace();
                }

                request.setAttribute("passwordSent", true);
                request.getRequestDispatcher("admin_login.jsp").forward(request, response);
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("alert('No user found with the provided email.');");
                out.println("location='forgot_password.jsp';");
                out.println("</script>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
    }
}

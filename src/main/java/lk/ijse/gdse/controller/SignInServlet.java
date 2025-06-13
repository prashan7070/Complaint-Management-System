package lk.ijse.gdse.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet("/signIn")

public class SignInServlet extends HttpServlet {

    @Resource(name = "jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = dataSource.getConnection()) {

            String sql = "SELECT user_id, role FROM users WHERE username = ? AND password = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String role = rs.getString("role");

                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("role", role);

                if ("ADMIN".equalsIgnoreCase(role)) {
                    request.getRequestDispatcher("view/AdminDashboard.jsp").forward(request, response);
                } else if ("EMPLOYEE".equalsIgnoreCase(role)) {
                    request.getRequestDispatcher("view/EmployeeDashboard.jsp").forward(request, response);

                } else {
                    response.sendRedirect("view/signIn.jsp?error=invalid_role");
                }

            } else {
                // Invalid login
                response.sendRedirect("view/signIn.jsp?error=invalid_credentials");
            }

        } catch (SQLException e) {
            throw new ServletException("Database error during login", e);
        }
    }



}

package lk.ijse.gdse.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lk.ijse.gdse.dao.UserDAO;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet("/signIn")

public class SignInServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try{

            ResultSet rs = new UserDAO(this.dataSource).getUser(username , password);

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                String role = rs.getString("role");
                String name = rs.getString("full_name");

                HttpSession session = request.getSession();
                session.setAttribute("user_id", userId);
                session.setAttribute("username", userId);
                session.setAttribute("role", role);
                session.setAttribute("fullName", name);

                if ("ADMIN".equals(role)) {

                    request.getRequestDispatcher("view/AdminDashboard.jsp").forward(request, response);

                } else  {

//                    request.getRequestDispatcher("view/EmployeeDashboard.jsp").forward(request, response);
//                    request.getRequestDispatcher("employee").forward(request, response);


                    response.sendRedirect(request.getContextPath() + "/employee");


                }

            } else {
//                response.sendRedirect("view/signIn.jsp?error=invalid_credentials");
                request.getRequestDispatcher("view/signIn.jsp?error=true").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException("Database error during login", e);
        }
    }



}

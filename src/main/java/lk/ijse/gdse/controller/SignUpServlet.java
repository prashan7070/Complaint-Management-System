package lk.ijse.gdse.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


@WebServlet("/signUp")

public class SignUpServlet extends HttpServlet {

    @Resource(name = "jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (name == null || username == null || password == null  || role == null ||
                username.isEmpty() || password.isEmpty() || role.isEmpty()) {
            response.sendRedirect("view/signUp.jsp?error=true");
            return;
        }


        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "INSERT INTO users (full_name , username, password, role) VALUES (?, ?, ?, ?)")) {

            preparedStatement.setString(1,name);
            preparedStatement.setString(2, username);
            preparedStatement.setString(3, password);
            preparedStatement.setString(4, role);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("view/signIn.jsp?success=true");
            } else {
                response.sendRedirect("view/signUp.jsp?error=true");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("view/signUp.jsp?error=true");
        }
    }


}

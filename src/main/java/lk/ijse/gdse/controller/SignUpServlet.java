package lk.ijse.gdse.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.dao.UserDAO;
import lk.ijse.gdse.model.UserModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


@WebServlet("/signUp")

public class SignUpServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
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

        UserModel userModel = new UserModel();
        userModel.setName(name);
        userModel.setUsername(username);
        userModel.setPassword(password);
        userModel.setRole(role);


        try {

            int rowsAffected = new UserDAO(this.dataSource).saveUser(userModel);

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

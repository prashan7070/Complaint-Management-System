package lk.ijse.gdse.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.dao.EmployeeDAO;
import lk.ijse.gdse.model.EmployeeModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/employee")

public class EmployeeServlet extends HttpServlet {


    @Resource(name = "jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String title = request.getParameter("title");
        String desc  = request.getParameter("description");

        if (title==null || desc ==null){
//            response.sendRedirect("view/EmployeeDashboard.jsp ? error = true");
            return;
        }


        try {

            EmployeeModel employeeModel = new EmployeeModel();
            employeeModel.setEmpId((Integer) request.getSession().getAttribute("user_id"));
            employeeModel.setTitle(title);
            employeeModel.setDescription(desc);

            int rowsAffected = new EmployeeDAO(this.dataSource).saveComplain(employeeModel);

            if (rowsAffected > 0) {
                response.sendRedirect("view/EmployeeDashboard.jsp?success=true");
            } else {
                response.sendRedirect("view/EmployeeDashboard.jsp?error=true");
            }


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {





    }
}

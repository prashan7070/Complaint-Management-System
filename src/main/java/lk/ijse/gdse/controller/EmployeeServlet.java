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
import java.util.List;

@WebServlet("/employee")

public class EmployeeServlet extends HttpServlet {


    @Resource(name = "jdbc/pool")
    private DataSource dataSource;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        String title = request.getParameter("title");
        String desc = request.getParameter("description");


        if (title == null || desc == null) {
            return;
        }


        try {

            EmployeeDAO employeeDAO = new EmployeeDAO(dataSource);
            String userId = (String) request.getSession().getAttribute("user_Id");
            int id = Integer.parseInt(userId);

            if ("add".equals(action)) {

                EmployeeModel employeeModel = new EmployeeModel();
                employeeModel.setEmpId(id);
                employeeModel.setTitle(title);
                employeeModel.setDescription(desc);

                int rowsAffected = employeeDAO.saveComplain(employeeModel);

                if (rowsAffected > 0) {
                    response.sendRedirect("view/EmployeeDashboard.jsp?success=true");
                } else {
                    response.sendRedirect("view/EmployeeDashboard.jsp?error=true");
                }


            } else if ("update".equals(action)) {

                int complaintId = Integer.parseInt(request.getParameter("complaintId"));
                EmployeeModel employeeModel = new EmployeeModel();
                employeeModel.setComplaintId(complaintId);
                employeeModel.setEmpId(id);
                employeeModel.setTitle(title);
                employeeModel.setDescription(desc);

                int rowsAffected  = employeeDAO.updateComplain(employeeModel);
                 if (rowsAffected > 0) {
                     request.setAttribute("message", "Complaint updated successfully");
                 } else {
                     request.setAttribute("message", "Complaint update unsuccessful!");
                 }

            } else if ("delete".equals(action)) {

                int complaintId = Integer.parseInt(request.getParameter("complaintId"));
                int rowsAffected = employeeDAO.deleteComplain(complaintId);

                if (rowsAffected > 0) {
                    request.setAttribute("message", "Complaint deleted successfully");
                } else {
                    request.setAttribute("message", "Complaint update unsuccessful!");
                }

            }


            List<EmployeeModel> complainList = employeeDAO.getAllComplains(id);
            request.setAttribute("userComplainList" , complainList);
            request.getRequestDispatcher("view/EmployeeDashboard.jsp").forward(request,response);


        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }
}

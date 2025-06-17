package lk.ijse.gdse.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.dao.EmployeeDAO;
import lk.ijse.gdse.model.EmployeeModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/employee")
public class EmployeeServlet extends HttpServlet {


    @Resource(name = "java:comp/env/jdbc/pool")
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
//            String userId = (String) request.getSession().getAttribute("user_id");
//            int id = Integer.parseInt(userId);

            int id = 0;

            Object userObj = request.getSession().getAttribute("user_id");
            if (userObj != null) {
                String userId = userObj.toString(); // avoid ClassCastException
                id = Integer.parseInt(userId);
            }

            HttpSession session = request.getSession();


            if ("add".equals(action)) {

                EmployeeModel employeeModel = new EmployeeModel();
                employeeModel.setEmpId(id);
                employeeModel.setTitle(title);
                employeeModel.setDescription(desc);

                int rowsAffected = employeeDAO.saveComplain(employeeModel);

                if (rowsAffected > 0) {
                    session.setAttribute("alertType", "success");
                    session.setAttribute("alertMsg", "Complaint saved successfully");

                } else {
                    session.setAttribute("alertType", "error");
                    session.setAttribute("alertMsg", "Complaint saved unsuccessful");

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
                     session.setAttribute("alertType", "success");
                     session.setAttribute("alertMsg", "Complaint updated successfully");

                 } else {
                     session.setAttribute("alertType", "error");
                     session.setAttribute("alertMsg", "Complaint update unsuccessful");

                 }

            } else if ("delete".equals(action)) {

                int complaintId = Integer.parseInt(request.getParameter("complaintId"));
                int rowsAffected = employeeDAO.deleteComplain(complaintId);

                if (rowsAffected > 0) {
                    session.setAttribute("alertType", "success");
                    session.setAttribute("alertMsg", "Complaint deleted successfully");

                } else {
                    session.setAttribute("alertType", "error");
                    session.setAttribute("alertMsg", "Complaint delete unsuccessful");

                }

            }

            response.sendRedirect("employee");
//            response.sendRedirect(request.getContextPath() + "/employee");



        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("This is get method");

        EmployeeDAO employeeDAO = new EmployeeDAO(dataSource);
        int id = 0;

        Object userObj = request.getSession().getAttribute("user_id");
        if (userObj != null) {
            String userId = userObj.toString(); // avoid ClassCastException
            id = Integer.parseInt(userId);
        }

        try {

            List<EmployeeModel> complainList = employeeDAO.getAllComplains(id);
            request.setAttribute("complainList" , complainList);
            request.getRequestDispatcher("view/EmployeeDashboard.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }



}

package lk.ijse.gdse.controller;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.ijse.gdse.dao.AdminDAO;
import lk.ijse.gdse.model.EmployeeModel;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Objects;

@WebServlet("/admin")

public class AdminServlet extends HttpServlet {

    @Resource(name = "java:comp/env/jdbc/pool")
    private DataSource dataSource;


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action");
        String complainId = req.getParameter("complaintId");
        String status = req.getParameter("status");
        String remark = req.getParameter("remarks");

        if (complainId==null || status==null){
            return;
        }

        try {

            AdminDAO adminDAO = new AdminDAO(dataSource);

            if ("update".equals(action)){

                EmployeeModel employeeModel = new EmployeeModel();
                employeeModel.setComplaintId(Integer.parseInt(complainId));
                employeeModel.setStatus(status);
                employeeModel.setRemarks(remark);

                int rowsAffected = adminDAO.updateComplainByAdmin(employeeModel);

                if (rowsAffected>0){

                    req.getSession().setAttribute("message" , "update Successful");

                } else {

                    req.getSession().setAttribute("message" , "update failed");

                }


            } else if ("delete".equals(action)) {

                if (!status.equalsIgnoreCase("resolved")){

                    int rowsAffected = adminDAO.deleteComplaint(complainId);

                    if (rowsAffected>0){

                        req.getSession().setAttribute("message" , "delete failed");

                    } else {

                        req.getSession().setAttribute("message" , "delete failed");

                    }

                }

            }


            resp.sendRedirect("admin");

            //            response.sendRedirect(request.getContextPath() + "/employee");


        } catch (Exception e) {
            throw new RuntimeException(e);
        }


    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        AdminDAO adminDAO = new AdminDAO(dataSource);
        String action = req.getParameter("action");
        String status = req.getParameter("searchStatus");

        try {

            if ("search".equals(action)){

                System.out.println("this is search method");

                List<EmployeeModel> complainListBySearch = adminDAO.getAllComplainsByStatus(status);
                req.setAttribute("selectedStatus" , status);
                req.setAttribute("complainList" , complainListBySearch);


            }else {

                System.out.println("this is not the search method");

                List<EmployeeModel> complainList = adminDAO.getAllComplains();
                req.setAttribute("complainList" , complainList);
            }



            int[] countData = adminDAO.getCountData();

            req.setAttribute("totalComplaints" , countData[0]);
            req.setAttribute("pendingComplaints" , countData[1]);
            req.setAttribute("inProgressComplaints" , countData[2]);
            req.setAttribute("resolvedComplaints" , countData[3]);

            req.getRequestDispatcher("view/AdminDashboard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


    }
}

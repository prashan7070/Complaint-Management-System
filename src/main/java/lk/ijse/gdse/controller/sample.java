package lk.ijse.gdse.controller;

public class sample {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        try {
            EmployeeDao employeeDao = new EmployeeDao(dataSource);
            String userIdStr = (String) req.getSession().getAttribute("user_id");
            int userId = Integer.parseInt(userIdStr);

            if ("add".equals(action)) {
                String title = req.getParameter("title");
                String description = req.getParameter("description");

                EmployeeModel employeeModel = new EmployeeModel();
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);
                employeeModel.setUser_id(userId);

                int result = employeeDao.addComplain(employeeModel);
                if (result > 0) {
                    req.setAttribute("message", "Complain added successfully");
                } else {
                    req.setAttribute("message", "Failed to add complaint");
                }
            } else if ("update".equals(action)) {
                int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
                String title = req.getParameter("title");
                String description = req.getParameter("description");

                EmployeeModel employeeModel = new EmployeeModel();
                employeeModel.setComplaint_id(complaintId);
                employeeModel.setTitle(title);
                employeeModel.setDescription(description);
                employeeModel.setUser_id(userId);

                int result = employeeDao.updateComplaint(employeeModel);
                if (result > 0) {
                    req.setAttribute("message", "Complaint updated successfully");
                } else {
                    req.setAttribute("message", "Failed to update complaint");
                }
            } else if ("delete".equals(action)) {
                int complaintId = Integer.parseInt(req.getParameter("complaint_id"));
                int result = employeeDao.deleteComplaint(complaintId);
                if (result > 0) {
                    req.setAttribute("message", "Complaint deleted successfully");
                } else {
                    req.setAttribute("message", "Failed to delete complaint");
                }
            }

            List<EmployeeModel> list = employeeDao.getComplaintsByUser(userId);
            req.setAttribute("complaintList", list);
            req.getRequestDispatcher("View/EmployeeDashBoard.jsp").forward(req, resp);

        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }



    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String userIdStr = (String) req.getSession().getAttribute("user_id");
            int userId = Integer.parseInt(userIdStr);
            List<EmployeeModel> list = new EmployeeDao(dataSource).getComplaintsByUser(userId);
            req.setAttribute("complaintList", list);
            req.getRequestDispatcher("View/EmployeeDashBoard.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
        }
    }


    public int addComplain(EmployeeModel employeeModel) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "INSERT INTO complaints (title, description, user_id) VALUES (?, ?, ?)")) {
            preparedStatement.setString(1, employeeModel.getTitle());
            preparedStatement.setString(2, employeeModel.getDescription());
            preparedStatement.setInt(3, employeeModel.getUser_id());
            return preparedStatement.executeUpdate();
        }
    }

    public int updateComplaint(EmployeeModel employeeModel) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "UPDATE complaints SET title = ?, description = ? WHERE complaint_id = ? AND user_id = ?")) {
            preparedStatement.setString(1, employeeModel.getTitle());
            preparedStatement.setString(2, employeeModel.getDescription());
            preparedStatement.setInt(3, employeeModel.getComplaint_id());
            preparedStatement.setInt(4, employeeModel.getUser_id());
            return preparedStatement.executeUpdate();
        }
    }




    public int deleteComplaint(int complaintId) throws SQLException {
        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(
                     "DELETE FROM complaints WHERE complaint_id = ?")) {
            preparedStatement.setInt(1, complaintId);
            return preparedStatement.executeUpdate();
        }
    }

    public List<EmployeeModel> getComplaintsByUser(int userId) throws SQLException {
        List<EmployeeModel> list = new ArrayList<>();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM complaints WHERE user_id = ?")) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EmployeeModel model = new EmployeeModel();
                    model.setComplaint_id(rs.getInt("complaint_id"));
                    model.setUser_id(rs.getInt("user_id"));
                    model.setTitle(rs.getString("title"));
                    model.setDescription(rs.getString("description"));
                    model.setStatus(rs.getString("status"));
                    model.setCreated_at(rs.getString("created_at"));
                    model.setUpdated_at(rs.getString("updated_at"));
                    list.add(model);
                }
            }
        }
        return list;
    }


    <%
    List<EmployeeModel> complaintList = (List<EmployeeModel>) request.getAttribute("complaintList");
                if (complaintList != null && !complaintList.isEmpty()) {
        for (EmployeeModel complaint : complaintList) {
            %>
            <tr onclick="selectComplaint('<%= complaint.getComplaint_id() %>', '<%= complaint.getTitle() %>', '<%= complaint.getDescription() %>')">
                <td><%= complaint.getComplaint_id() %></td>
                <td><%= complaint.getUser_id() %></td>
                <td><%= complaint.getTitle() %></td>
                <td><%= complaint.getDescription() %></td>
                <td><%= complaint.getStatus() != null ? complaint.getStatus() : "Pending" %></td>
                <td><%= complaint.getCreated_at() != null ? complaint.getCreated_at() : "--" %></td>
                <td><%= complaint.getUpdated_at() != null ? complaint.getUpdated_at() : "--" %></td>
                <td>
                    <button onclick="selectComplaint('<%= complaint.getComplaint_id() %>', '<%= complaint.getTitle() %>', '<%= complaint.getDescription() %>')">Select</button>
                </td>
            </tr>
            <%
        }
    } else {
            %>




}

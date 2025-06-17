<%@ page import="lk.ijse.gdse.model.EmployeeModel" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard - Complaint Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 25px 30px;
            text-align: center;
            position: relative;
        }

        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            opacity: 0.3;
        }

        .header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            position: relative;
            z-index: 1;
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .user-info {
            position: absolute;
            top: 20px;
            right: 30px;
            background: rgba(255, 255, 255, 0.2);
            padding: 10px 15px;
            border-radius: 25px;
            font-size: 0.9rem;
            z-index: 1;
        }

        .main-content {
            padding: 30px;
        }

        .section {
            margin-bottom: 40px;
            background: white;
            border-radius: 12px;
            padding: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            border: 1px solid #e3e8ee;
        }

        .section-title {
            font-size: 1.8rem;
            color: #2c3e50;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title::before {
            content: '📋';
            font-size: 1.5rem;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 2fr;
            gap: 20px;
            margin-bottom: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        label {
            font-weight: 600;
            color: #34495e;
            margin-bottom: 8px;
            font-size: 1rem;
        }

        input[type="text"], input[type="hidden"], textarea {
            padding: 12px 15px;
            border: 2px solid #e8e8e8;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #fafafa;
        }

        input[type="text"]:focus, textarea:focus {
            outline: none;
            border-color: #3498db;
            background: white;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            transform: translateY(-1px);
        }

        textarea {
            resize: vertical;
            min-height: 120px;
            font-family: inherit;
        }

        .button-group {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 20px;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            box-shadow: 0 4px 15px rgba(52, 152, 219, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9, #1f618d);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(52, 152, 219, 0.4);
        }

        .btn-success {
            background: linear-gradient(135deg, #27ae60, #229954);
            color: white;
            box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #229954, #1e8449);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
        }

        .btn-warning {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            color: white;
            box-shadow: 0 4px 15px rgba(243, 156, 18, 0.3);
        }

        .btn-warning:hover {
            background: linear-gradient(135deg, #e67e22, #d35400);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(243, 156, 18, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #95a5a6, #7f8c8d);
            color: white;
            box-shadow: 0 4px 15px rgba(149, 165, 166, 0.3);
        }

        .btn-secondary:hover {
            background: linear-gradient(135deg, #7f8c8d, #566573);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(149, 165, 166, 0.4);
        }

        .table-container {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            background: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }

        thead {
            background: linear-gradient(135deg, #34495e, #2c3e50);
            color: white;
        }

        th, td {
            padding: 15px 12px;
            text-align: left;
            border-bottom: 1px solid #e8e8e8;
        }

        th {
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        tbody tr {
            transition: all 0.3s ease;
        }

        tbody tr:hover {
            background: #f8f9fa;
            transform: translateX(2px);
        }

        tbody tr:nth-child(even) {
            background: #fafafa;
        }

        tbody tr:nth-child(even):hover {
            background: #f0f0f0;
        }

        .status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }

        .status-in-progress {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .status-resolved {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-rejected {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.85rem;
            border-radius: 6px;
        }

        .no-data {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
            font-style: italic;
            font-size: 1.1rem;
        }

        .logout-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }

        .small-toast {
            font-size: 0.8rem;
            padding: 8px 14px;
            width: 260px;
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
                border-radius: 10px;
            }

            .header {
                padding: 20px 15px;
            }

            .header h1 {
                font-size: 2rem;
            }

            .user-info {
                position: static;
                margin-top: 15px;
                text-align: center;
            }

            .main-content {
                padding: 20px 15px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .button-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }

            .table-container {
                font-size: 0.85rem;
            }

            th, td {
                padding: 10px 8px;
            }
        }

        .fade-in {
            animation: fadeIn 0.6s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>




</head>
<body>

<form method="post" action="${pageContext.request.contextPath}/logout" class="logout-btn">
    <button type="submit" class="btn btn-danger btn-sm">Logout</button>
</form>

<div class="container fade-in">
    <div class="header">

        <div class="user-info">
            Welcome, <%= session.getAttribute("fullName") != null ? session.getAttribute("fullName") : "Employee" %>
        </div>
        <h1>🏛️ Municipal Complaint Management</h1>
        <p>Employee Dashboard - Submit and Track Your Complaints</p>
    </div>

    <div class="main-content">
        <div class="section">
            <h2 class="section-title">Submit New Complaint</h2>

            <form method="post" action="${pageContext.request.contextPath}/employee">
<%--                <input type="hidden" name="action" value="add" id="actionField">--%>
                <input type="hidden" name="complaintId" value="" id="complaintId">

                <div class="form-grid">
                    <div class="form-group">
                        <label for="title">Complaint Title *</label>
                        <input type="text" id="title" name="title" required
                               placeholder="Enter complaint title">
                    </div>

                    <div class="form-group full-width">
                        <label for="description">Complaint Description *</label>
                        <textarea id="description" name="description" required
                                  placeholder="Describe your complaint in detail..."></textarea>
                    </div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-primary" id="addBtn" name="action" value="add">
                        ➕ Add Complaint
                    </button>
                    <button type="submit" class="btn btn-success" id="updateBtn" name="action" value="update">
                        ✏️ Update Complaint
                    </button>
                    <button type="submit" class="btn btn-danger" id="deleteBtn"
                            onclick="return confirm('Are you sure you want to delete this complaint?')" name="action" value="delete">
                        🗑️ Delete Complaint
                    </button>
                    <button type="button" class="btn btn-secondary" id="resetBtn" onclick="clearForm()" name="action" value="reset">
                        🧹 Clear Form
                    </button>
                </div>
            </form>
        </div>

        <!-- Complaints List Section -->
        <div class="section">
            <h2 class="section-title">My Complaints</h2>

            <div class="table-container">
                <table>
                    <thead>
                    <tr>
                        <th>Complain ID</th>
                        <th>Employee ID</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Created At</th>
                        <th>Updated At</th>
                        <th>Remark</th>

                    </tr>
                    </thead>

                    <tbody>



                            <%
                                List<EmployeeModel> complaintList = (List<EmployeeModel>) request.getAttribute("complainList");
                                if (complaintList != null && !complaintList.isEmpty()) {
                                    for (EmployeeModel complaint : complaintList) {
                            %>

                            <tr onclick="selectComplaint('<%= complaint.getComplaintId() %>', '<%= complaint.getTitle() %>', '<%= complaint.getDescription() %>' , '<%= complaint.getStatus() %>')">
                                <td><%= complaint.getComplaintId() %></td>
                                <td><%= complaint.getEmpId() %></td>
                                <td><%= complaint.getTitle() %></td>
                                <td><%= complaint.getDescription() %></td>
<%--                                <td><%= complaint.getStatus() != null ? complaint.getStatus() : "Pending" %></td>--%>

                                <td>
                                    <span class="status <%=
                                        (complaint.getStatus() != null) ?
                                            (complaint.getStatus().equalsIgnoreCase("Pending") ? "status-pending" :
                                             complaint.getStatus().equalsIgnoreCase("In Progress") ? "status-in-progress" :
                                             complaint.getStatus().equalsIgnoreCase("Resolved") ? "status-resolved" :
                                             "status-pending") :
                                            "status-pending" %>">
                                        <%= complaint.getStatus() != null ? complaint.getStatus() : "Pending" %>
                                    </span>
                                </td>



                                <td><%= complaint.getCreatedDate() != null ? complaint.getCreatedDate() : "--" %></td>
                                <td><%= complaint.getUpdatedDate() != null ? complaint.getUpdatedDate() : "--" %></td>
                                <td><%= complaint.getRemarks() != null ? complaint.getRemarks() : "No Remarks" %></td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr><td colspan="7">No complaints found.</td></tr>
                            <%
                                }
                            %>

                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>



<%

    String alertType = (String) request.getSession().getAttribute("alertType");
    String alertMsg = (String) request.getSession().getAttribute("alertMsg");

    if (alertType!=null || alertMsg!=null){
        session.removeAttribute("alertType");
        session.removeAttribute("alertType");

%>

    <script>

        Swal.fire({
            toast: true,
            position: "top-end",
            icon: '<%=alertType%>',
            title: '<%=alertMsg%>',
            showConfirmButton: false,
            timer: 1500,
            timerProgressBar: true,
            customClass: {
                popup: 'small-toast'
            }
        });


    </script>


<%
    }
%>


<script>

    function selectComplaint(id, title, description ,status) {
        document.getElementById('complaintId').value = id;
        document.getElementById('title').value = title;
        document.getElementById('description').value = description;

        console.log(status);

        document.getElementById('addBtn').disabled = true;

        const updateBtn = document.getElementById('updateBtn');
        const deleteBtn = document.getElementById('deleteBtn');

        updateBtn.style.display = 'inline-block';
        deleteBtn.style.display = 'inline-block';

        if (status === 'RESOLVED') {
            updateBtn.disabled = true;
            deleteBtn.disabled = true;
        } else {
            updateBtn.disabled = false;
            deleteBtn.disabled = false;
        }

        document.querySelector('.section').scrollIntoView({ behavior: 'smooth', block: 'start' });
    }


    function clearForm() {
        document.getElementById('title').value = '';
        document.getElementById('description').value = '';
        document.getElementById('complaintId').value = '';
        document.getElementById('actionField').value = 'add';
        document.getElementById('addBtn').disabled = false;

        const updateBtn = document.getElementById('updateBtn');
        const deleteBtn = document.getElementById('deleteBtn');

        updateBtn.style.display = 'none';
        deleteBtn.style.display = 'none';
        updateBtn.disabled = false;
        deleteBtn.disabled = false;

    }




</script>
</body>
</html>
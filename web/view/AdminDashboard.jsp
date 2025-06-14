<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%-- Import your model classes here --%>
<%-- import com.yourpackage.model.EmployeeModel; --%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Complaint Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            max-width: 1400px;
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

        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            border: 1px solid #e3e8ee;
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
        }

        .stat-card h3 {
            font-size: 1.8rem;
            margin-bottom: 5px;
            font-weight: 700;
        }

        .stat-card p {
            color: #7f8c8d;
            font-size: 0.9rem;
            font-weight: 600;
        }

        .stat-total { color: #3498db; }
        .stat-pending { color: #f39c12; }
        .stat-resolved { color: #27ae60; }

        .section {
            margin-bottom: 30px;
            background: white;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
            border: 1px solid #e3e8ee;
        }

        .section-title {
            font-size: 1.4rem;
            color: #2c3e50;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .section-title::before {
            content: '📊';
            font-size: 1.2rem;
        }

        .table-container {
            overflow-x: auto;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            background: white;
            max-height: 400px;
            overflow-y: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.8rem;
        }

        thead {
            background: linear-gradient(135deg, #34495e, #2c3e50);
            color: white;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        th, td {
            padding: 8px 6px;
            text-align: left;
            border-bottom: 1px solid #e8e8e8;
        }

        th {
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            font-size: 0.75rem;
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
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
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

        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-size: 0.85rem;
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

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.8rem;
        }

        .btn-success {
            background: linear-gradient(135deg, #27ae60, #229954);
            color: white;
            box-shadow: 0 3px 10px rgba(39, 174, 96, 0.3);
        }

        .btn-success:hover {
            background: linear-gradient(135deg, #229954, #1e8449);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(39, 174, 96, 0.4);
        }

        .btn-danger {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            box-shadow: 0 3px 10px rgba(231, 76, 60, 0.3);
        }

        .btn-danger:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
        }

        .btn-primary {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            box-shadow: 0 3px 10px rgba(52, 152, 219, 0.3);
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, #2980b9, #1f618d);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
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

        .refresh-section {
            text-align: center;
            margin-top: 15px;
        }

        /* Modern Control Section Styles */
        .control-section {
            margin-bottom: 20px;
            background: linear-gradient(135deg, #f8f9fa, #ffffff);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            border: 1px solid #e3e8ee;
        }

        .control-title {
            font-size: 1.4rem;
            color: #2c3e50;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 700;
        }

        .control-title::before {
            content: '⚙️';
            font-size: 1.2rem;
        }

        .control-form {
            display: grid;
            grid-template-columns: 1fr 2fr 120px;
            gap: 15px;
            align-items: end;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .form-label {
            font-size: 0.8rem;
            font-weight: 600;
            color: #34495e;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .modern-select {
            position: relative;
            display: block;
        }

        .modern-select select {
            width: 100%;
            padding: 8px 12px;
            border: 2px solid #e3e8ee;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 500;
            color: #2c3e50;
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            appearance: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        }

        .modern-select select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
            transform: translateY(-1px);
        }

        .modern-select::after {
            content: '▼';
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            color: #7f8c8d;
            font-size: 0.7rem;
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .modern-select:hover::after {
            color: #3498db;
        }

        .modern-input {
            width: 100%;
            padding: 8px 12px;
            border: 2px solid #e3e8ee;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 500;
            color: #2c3e50;
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            transition: all 0.3s ease;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05);
        }

        .modern-input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
            transform: translateY(-1px);
        }

        .modern-input::placeholder {
            color: #95a5a6;
            font-style: italic;
            font-size: 0.8rem;
        }

        .btn-update {
            background: linear-gradient(135deg, #8e44ad, #9b59b6);
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            box-shadow: 0 3px 10px rgba(142, 68, 173, 0.3);
            position: relative;
            overflow: hidden;
        }

        .btn-update::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn-update:hover {
            background: linear-gradient(135deg, #7d3c98, #8e44ad);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(142, 68, 173, 0.4);
        }

        .btn-update:hover::before {
            left: 100%;
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

            .stats-section {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .table-container {
                font-size: 0.8rem;
            }

            th, td {
                padding: 8px 6px;
            }

            .control-form {
                grid-template-columns: 1fr;
                gap: 15px;
            }

            .control-section {
                padding: 20px;
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
<!-- Logout Button -->
<form method="post" action="${pageContext.request.contextPath}/logout" class="logout-btn">
    <button type="submit" class="btn btn-danger btn-sm">Logout</button>
</form>

<div class="container fade-in">
    <!-- Header Section -->
    <div class="header">
        <div class="user-info">
            Welcome, <%= session.getAttribute("fullName") != null ? session.getAttribute("fullName") : "Admin" %>
        </div>
        <h1>🏛️ Municipal Complaint Management</h1>
        <p>Admin Dashboard - Manage All Complaints</p>
    </div>

    <div class="main-content">
        <!-- Statistics Section -->
        <div class="stats-section">
            <div class="stat-card">
                <h3 class="stat-total"><%= request.getAttribute("totalComplaints") != null ? request.getAttribute("totalComplaints") : "0" %></h3>
                <p>Total Complaints</p>
            </div>
            <div class="stat-card">
                <h3 class="stat-pending"><%= request.getAttribute("pendingComplaints") != null ? request.getAttribute("pendingComplaints") : "0" %></h3>
                <p>Pending Complaints</p>
            </div>
            <div class="stat-card">
                <h3 class="stat-resolved"><%= request.getAttribute("resolvedComplaints") != null ? request.getAttribute("resolvedComplaints") : "0" %></h3>
                <p>Resolved Complaints</p>
            </div>
        </div>

        <!-- Control Section -->
        <div class="control-section">
            <h2 class="control-title">Complaint Management Controls</h2>
            <form method="post" action="${pageContext.request.contextPath}/admin" class="control-form">
                <input type="hidden" name="complaintId" id="selectedComplaintId">
                <input type="hidden" name="empId" id="selectedEmpId">

                <div class="form-group">
                    <label class="form-label">Status</label>
                    <div class="modern-select">
                        <select name="status" id="statusSelect" required>
                            <option value="">Select Status</option>
                            <option value="Pending">Pending</option>
                            <option value="In Progress">In Progress</option>
                            <option value="Resolved">Resolved</option>
                            <option value="Rejected">Rejected</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Remarks</label>
                    <input type="text" name="remark" id="remarkInput" class="modern-input"
                           placeholder="Enter your remarks here...">
                </div>

                <div class="form-group">
                    <button type="submit" class="btn-update">
                        ✨ Update Status
                    </button>
                </div>
            </form>
        </div>

        <!-- Complaints Management Section -->
        <div class="section">
            <h2 class="section-title">All Complaints Management</h2>

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
                        // Get complaint list from request attribute
                        List<?> complainList = (List<?>) request.getAttribute("complainList");

                        if (complainList != null && !complainList.isEmpty()) {
                            // In a real application, cast to your actual model class
                            // for (EmployeeModel complaint : (List<EmployeeModel>) complainList) {

                            // Sample data for demonstration - replace with actual data iteration
                            for (int i = 0; i < 3; i++) {
                    %>
                    <tr onclick="selectComplaint('CMP00<%= i + 1 %>', 'EMP00<%= i + 1 %>', '<%= (i == 0) ? "Pending" : (i == 1) ? "In Progress" : "Resolved" %>', '<%= (i == 2) ? "Issue resolved successfully" : "" %>')" style="cursor: pointer;">
                        <td>CMP00<%= i + 1 %></td>
                        <td>EMP00<%= i + 1 %></td>
                        <td>Sample Complaint <%= i + 1 %></td>
                        <td>Description of complaint <%= i + 1 %></td>
                        <td>
                            <%-- Dynamic status class assignment --%>
                            <span class="status <%= (i == 0) ? "status-pending" : (i == 1) ? "status-in-progress" : "status-resolved" %>">
                                        <%= (i == 0) ? "Pending" : (i == 1) ? "In Progress" : "Resolved" %>
                                    </span>
                        </td>
                        <td>2025-06-<%= 12 + i %></td>
                        <td>2025-06-<%= 12 + i %></td>
                        <td><%= (i == 2) ? "Issue resolved successfully" : "" %></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="8" class="no-data">
                            No complaints found in the system.
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>

            <!-- Refresh Section -->
            <div class="refresh-section">
                <form method="get" action="${pageContext.request.contextPath}/admin">
                    <input type="hidden" name="action" value="refresh">
                    <button type="submit" class="btn btn-primary">
                        🔄 Refresh Dashboard
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>

    function selectComplaint(complaintId, empId, status, remark) {
        document.getElementById('selectedComplaintId').value = complaintId;
        document.getElementById('selectedEmpId').value = empId;
        document.getElementById('statusSelect').value = status || '';
        document.getElementById('remarkInput').value = remark || '';

        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.style.backgroundColor = '';
            row.style.borderLeft = '';
        });

        event.currentTarget.style.backgroundColor = '#e3f2fd';
        event.currentTarget.style.borderLeft = '4px solid #3498db';
    }

    function clearForm() {
        document.getElementById('selectedComplaintId').value = '';
        document.getElementById('selectedEmpId').value = '';
        document.getElementById('statusSelect').value = '';
        document.getElementById('remarkInput').value = '';

        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.style.backgroundColor = '';
            row.style.borderLeft = '';
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        const controlForm = document.querySelector('.control-form');

        if (controlForm) {
            controlForm.addEventListener('submit', function(e) {
                const complaintId = document.getElementById('selectedComplaintId').value;
                const statusSelect = document.getElementById('statusSelect');
                const remarkInput = document.getElementById('remarkInput');

                if (!complaintId) {
                    e.preventDefault();
                    alert('Please select a complaint from the table first.');
                    return false;
                }

                if (!statusSelect.value) {
                    e.preventDefault();
                    alert('Please select a status before updating.');
                    statusSelect.focus();
                    return false;
                }

                if (statusSelect.value === 'Resolved' && !remarkInput.value.trim()) {
                    const confirmResolve = confirm('You are marking this complaint as resolved without a remark. Continue?');
                    if (!confirmResolve) {
                        e.preventDefault();
                        remarkInput.focus();
                        return false;
                    }
                }

                // Show loading state
                const submitBtn = controlForm.querySelector('.btn-update');
                submitBtn.innerHTML = '⏳ Updating...';
                submitBtn.disabled = true;
            });
        }
    });

    // Enhanced table row interactions
    document.addEventListener('DOMContentLoaded', function() {
        const tableRows = document.querySelectorAll('tbody tr');

        tableRows.forEach(row => {
            row.addEventListener('mouseenter', function() {
                if (!this.style.backgroundColor || this.style.backgroundColor === '') {
                    this.style.backgroundColor = '#f8f9fa';
                }
            });

            row.addEventListener('mouseleave', function() {
                if (this.style.backgroundColor === 'rgb(248, 249, 250)') {
                    this.style.backgroundColor = '';
                }
            });
        });
    });

    // Add clear selection button functionality
    function addClearButton() {
        const controlSection = document.querySelector('.control-section');
        if (controlSection) {
            const clearBtn = document.createElement('button');
            clearBtn.type = 'button';
            clearBtn.className = 'btn btn-sm';
            clearBtn.innerHTML = '🗑️ Clear Selection';
            clearBtn.onclick = clearForm;
            clearBtn.style.marginTop = '10px';
            clearBtn.style.background = '#95a5a6';
            clearBtn.style.color = 'white';

            controlSection.appendChild(clearBtn);
        }
    }

    // Initialize clear button
    document.addEventListener('DOMContentLoaded', addClearButton);
</script>
</body>
</html>
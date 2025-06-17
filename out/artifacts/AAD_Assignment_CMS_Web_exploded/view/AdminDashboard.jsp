<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="lk.ijse.gdse.model.EmployeeModel" %>


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


        .btn-delete {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
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
            box-shadow: 0 3px 10px rgba(231, 76, 60, 0.3);
            position: relative;
            overflow: hidden;
            width: 100%;
            margin-top: 10px; /* Add space between update and delete buttons */
        }

        .btn-delete::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, #c0392b, #a93226);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
        }

        .btn-delete:hover::before {
            left: 100%;
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
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
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

        .modern-input[readonly] {
            background: linear-gradient(135deg, #ecf0f1, #f8f9fa);
            border-color: #d5dbdb;
            color: #7f8c8d;
            cursor: not-allowed;
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
            width: 100%;
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

        .form-group-wide {
            grid-column: span 2;
        }


        .search-section {
            margin-bottom: 25px;
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            border: 1px solid #e3e8ee;
        }

        .search-title {
            font-size: 1.3rem;
            color: #2c3e50;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 700;
        }

        .search-title::before {
            content: '🔍';
            font-size: 1.1rem;
        }

        .search-form {
            display: flex;
            align-items: end;
            gap: 15px;
            flex-wrap: wrap;
        }

        .search-group {
            display: flex;
            flex-direction: column;
            gap: 5px;
            min-width: 150px;
        }

        .search-label {
            font-size: 0.8rem;
            font-weight: 600;
            color: #34495e;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .search-form .modern-select {
            position: relative;
        }

        .search-form .modern-select select {
            width: 100%;
            padding: 10px 12px;
            border: 2px solid #e3e8ee;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 500;
            color: #2c3e50;
            background: linear-gradient(135deg, #ffffff, #f8f9fa);
            appearance: none;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
            min-width: 180px;
        }

        .search-form .modern-select select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
            transform: translateY(-1px);
        }

        .search-form .modern-select::after {
            content: '▼';
            position: absolute;
            top: 50%;
            right: 12px;
            transform: translateY(-50%);
            color: #7f8c8d;
            font-size: 0.7rem;
            pointer-events: none;
            transition: all 0.3s ease;
        }

        .search-form .modern-select:hover::after {
            color: #3498db;
        }

        .btn-search {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            box-shadow: 0 3px 10px rgba(52, 152, 219, 0.3);
            position: relative;
            overflow: hidden;
            min-width: 120px;
        }

        .btn-search::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn-search:hover {
            background: linear-gradient(135deg, #2980b9, #1f618d);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
        }

        .btn-search:hover::before {
            left: 100%;
        }

        .btn-clear {
            background: linear-gradient(135deg, #95a5a6, #7f8c8d);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            box-shadow: 0 3px 10px rgba(149, 165, 166, 0.3);
            position: relative;
            overflow: hidden;
            min-width: 120px;
        }

        .btn-clear::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }

        .btn-clear:hover {
            background: linear-gradient(135deg, #7f8c8d, #6c7b7b);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(149, 165, 166, 0.4);
        }

        .btn-clear:hover::before {
            left: 100%;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
                align-items: stretch;
            }

            .search-group {
                min-width: 100%;
            }

            .search-form .modern-select select,
            .btn-search,
            .btn-clear {
                min-width: 100%;
            }
        }

        @media (max-width: 480px) {
            .search-section {
                padding: 15px;
            }

            .search-title {
                font-size: 1.1rem;
            }
        }


        @media (max-width: 1024px) {
            .control-form {
                grid-template-columns: repeat(2, 1fr);
            }

            .form-group-wide {
                grid-column: span 2;
            }
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

            .form-group-wide {
                grid-column: span 1;
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
                <h3 class="stat-total">
                    <%= request.getAttribute("totalComplaints") != null ? request.getAttribute("totalComplaints") : "0" %>
                </h3>
                <p>Total Complaints</p>
            </div>
            <div class="stat-card">
                <h3 class="stat-pending">
                    <%= request.getAttribute("pendingComplaints") != null ? request.getAttribute("pendingComplaints") : "0" %>
                </h3>
                <p>Pending Complaints</p>
            </div>
            <div class="stat-card">
                <h3 class="stat-pending">
                    <%= request.getAttribute("inProgressComplaints") != null ? request.getAttribute("inProgressComplaints") : "0" %>
                </h3>
                <p>In Progress Complaints</p>
            </div>
            <div class="stat-card">
                <h3 class="stat-resolved">
                    <%= request.getAttribute("resolvedComplaints") != null ? request.getAttribute("resolvedComplaints") : "0" %>
                </h3>
                <p>Resolved Complaints</p>
            </div>
        </div>

        <!-- Control Section -->
        <div class="control-section">
            <form method="post" action="${pageContext.request.contextPath}/admin" class="control-form">


                <div class="form-group">
                    <label class="form-label">Complaint ID</label>
                    <input type="text" name="complaintId" id="complaintId" class="modern-input" readonly
                           placeholder="Select a complaint...">
                </div>

                <div class="form-group">
                    <label class="form-label">Status</label>
                    <div class="modern-select">
                        <select name="status" id="status" required>
<%--                            <option value="">Select Status</option>--%>
                            <option value="Pending">Pending</option>
                            <option value="In_Progress">In Progress</option>
                            <option value="Resolved">Resolved</option>
                        </select>
                    </div>
                </div>

                <div class="form-group form-group-wide">
                    <label class="form-label">Title</label>
                    <input type="text" id="title" class="modern-input" readonly
                           placeholder="Complaint title will appear here...">
                </div>

                <div class="form-group form-group-wide">
                    <label class="form-label">Description</label>
                    <input type="text" id="description" class="modern-input" readonly
                           placeholder="Complaint description will appear here...">
                </div>

                <div class="form-group form-group-wide">
                    <label class="form-label">Remarks</label>
                    <input type="text" name="remarks" id="remarks" class="modern-input"
                           placeholder="Enter your remarks here...">
                </div>

                <div class="form-group">
                    <button type="submit" class="btn-update" name="action" value="update" id="updateBtn">
                        ✨ Update Status
                    </button>
                    <button type="submit" class="btn-delete" name="action" value="delete" id="deleteBtn">
                        🗑️ Delete Status
                    </button>
                </div>
            </form>
        </div>


        <!-- Search Section -->
        <div class="search-section">
            <h2 class="search-title">Search & Filter Complaints</h2>
            <form method="get" action="${pageContext.request.contextPath}/admin" class="search-form">
                <div class="search-group">
                    <label class="search-label">Filter by Status</label>
                    <div class="modern-select">

                        <%
                            String selectedStatus = (String) request.getAttribute("selectedStatus");
                            System.out.println(selectedStatus);

                        %>

                        <select name="searchStatus" id="searchStatus">
<%--                            <option value="">All Status</option>--%>
                            <option value="Pending" <%= "Pending".equals(selectedStatus) ? "selected" : "" %>>Pending</option>
                            <option value="In_Progress" <%= "In_Progress".equals(selectedStatus) ? "selected" : ""  %>>In Progress</option>
                            <option value="Resolved" <%= "Resolved".equals(selectedStatus) ? "selected" : "" %>>Resolved</option>
                        </select>
                    </div>
                </div>
                <div class="search-group">
                    <button type="submit" class="btn-search" name="action" value="search">
                        🔍 Search
                    </button>
                </div>
                <div class="search-group">
                    <button type="submit" class="btn-clear" name="action" value="clear">
                        ↻ Clear Filter
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
                                List<EmployeeModel> complaintList = (List<EmployeeModel>) request.getAttribute("complainList");
                                if (complaintList != null && !complaintList.isEmpty()) {
                                    for (EmployeeModel complaint : complaintList) {
                            %>

                            <tr onclick="selectComplaint('<%= complaint.getComplaintId() %>', '<%= complaint.getTitle() %>', '<%= complaint.getDescription() %>','<%= complaint.getStatus() %>', '<%= complaint.getRemarks() %>')">
                                <td><%= complaint.getComplaintId() %></td>
                                <td><%= complaint.getEmpId() %></td>
                                <td><%= complaint.getTitle() %></td>
                                <td><%= complaint.getDescription() %></td>
                                <%--                                <td><%= complaint.getStatus() != null ? complaint.getStatus() : "Pending" %></td>--%>

                                <td>
                                    <span class="status <%=
                                        (complaint.getStatus() != null) ?
                                            (complaint.getStatus().equalsIgnoreCase("PENDING") ? "status-pending" :
                                             complaint.getStatus().equalsIgnoreCase("IN_PROGRESS") ? "status-in-progress" :
                                             complaint.getStatus().equalsIgnoreCase("RESOLVED") ? "status-resolved" :
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
                            <tr><td colspan="8">No complaints found.</td></tr>
                            <%
                                }
                            %>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>



    function selectComplaint(complaintId, title, description, status, remarks){

        console.log(status);

        document.getElementById('complaintId').value = complaintId;
        document.getElementById('title').value = title;
        document.getElementById('description').value = description;

        const statusSelect = document.getElementById('status');

        statusSelect.options[statusSelect.selectedIndex].text = status
            ? status.toLowerCase().replace(/_/g, ' ').replace(/\b\w/g, c => c.toUpperCase())
            : 'Pending';

        document.getElementById('remarks').value = remarks || '';

        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.style.backgroundColor = '';
            row.style.borderLeft = '';
        });

        event.currentTarget.style.backgroundColor = '#e3f2fd';
        event.currentTarget.style.borderLeft = '4px solid #3498db';

        document.querySelector('.control-section').scrollIntoView({ behavior: 'smooth', block: 'start' });

    }

    function clearForm() {
        document.getElementById('complaintId').value = '';
        document.getElementById('title').value = '';
        document.getElementById('description').value = '';
        document.getElementById('status').value = '';
        document.getElementById('remarks').value = '';

        const tableRows = document.querySelectorAll('tbody tr');
        tableRows.forEach(row => {
            row.style.backgroundColor = '';
            row.style.borderLeft = '';
        });
    }

</script>
</body>
</html>
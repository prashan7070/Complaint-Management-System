<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Employee Dashboard</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 20px;
        }

        .dashboard {
            max-width: 1000px;
            margin: auto;
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-bottom: 30px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
        }

        button {
            width: 150px;
            padding: 10px;
            background-color: #007bff;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            align-self: flex-end;
        }

        button:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        table thead {
            background-color: #007bff;
            color: white;
        }

        table th, table td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        table tbody tr:hover {
            background-color: #f1f1f1;
        }
    </style>
</head>

<body>
<div class="dashboard">
    <h2>Welcome to Admin Dashboard</h2>

    <!-- Complaint Submission Form -->
    <form action="SubmitComplaintServlet" method="post">
        <input type="text" name="title" placeholder="Complaint Title" required />
        <textarea name="description" rows="4" placeholder="Complaint Description" required></textarea>
        <button type="submit">Submit Complaint</button>
    </form>

    <!-- Complaint Table -->
    <table>
        <thead>
        <tr>
            <th>Complaint ID</th>
            <th>Title</th>
            <th>Description</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Updated At</th>
        </tr>
        </thead>
        <tbody>
        <%-- Example Row (replace with dynamic data using JSTL or scriptlet) --%>
        <tr>
            <td>1</td>
            <td>AC not working</td>
            <td>Room 302 AC doesn't turn on</td>
            <td>PENDING</td>
            <td>2025-06-13 10:23</td>
            <td>2025-06-13 10:23</td>
        </tr>
        </tbody>
    </table>
</div>
</body>
</html>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .signup-container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 320px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        input[type="text"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px;
            margin: 8px 0 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .signup-btn {
            background-color: #28a745;
            color: white;
        }

        .signup-btn:hover {
            background-color: #1e7e34;
        }

        .signin-btn {
            background-color: #007bff;
            color: white;
            margin-top: 10px;
        }

        .signin-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="signup-container">
    <h2>Sign Up</h2>

    <form action="${pageContext.request.contextPath}/signUp" method="post">
        <input type="text" name="name" placeholder="Full Name" required />
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />

        <select name="role" required>
            <option value="">-- Select Role --</option>
            <option value="Employee">Employee</option>
            <option value="Admin">Admin</option>
        </select>

        <button type="submit" class="signup-btn">Sign Up</button>
    </form>

    <button class="signin-btn" onclick="window.location.href='${pageContext.request.contextPath}/view/signIn.jsp'">Sign In</button>
</div>
</body>
</html>

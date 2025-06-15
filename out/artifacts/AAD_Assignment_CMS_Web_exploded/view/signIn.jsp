<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign In</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            background-color: white;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            width: 300px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        input[type="text"],
        input[type="password"] {
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
            background-color: #007bff;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .signup-btn {
            background-color: #28a745;
        }

        .signup-btn:hover {
            background-color: #1e7e34;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Sign In</h2>

    <%
        String successMsg = request.getParameter("success");
        if ("true".equals(successMsg)) {
    %>
    <div style="background-color: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
        Sign up successful! Please sign in.
    </div>
    <%
        }

        String logoutMsg = request.getParameter("logout");
        if ("true".equals(logoutMsg)) {
    %>
    <div style="background-color: #d1ecf1; color: #0c5460; padding: 10px; border-radius: 5px; margin-bottom: 15px;">
        You have logged out successfully.
    </div>
    <%
        }
    %>

    <form action="${pageContext.request.contextPath}/signIn" method="post">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <button type="submit">Sign In</button>
        <button type="button" class="signup-btn" onclick="window.location.href='${pageContext.request.contextPath}/view/signUp.jsp'">Sign Up</button>
    </form>
</div>
</body>
</html>

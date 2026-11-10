
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Fashion Store</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/auth.css">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
}

body {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: linear-gradient(135deg, #fce4ec, #e1bee7);
}

.login-container {
    width: 380px;
    background: white;
    padding: 40px;
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

h2 {
    text-align: center;
    color: #ad1457;
    margin-bottom: 10px;
}

.subtitle {
    text-align: center;
    color: #777;
    margin-bottom: 25px;
}

.input-group {
    margin-bottom: 20px;
}

.input-group label {
    display: block;
    margin-bottom: 8px;
    color: #333;
    font-weight: bold;
}

.input-group input {
    width: 100%;
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 7px;
    outline: none;
}

.input-group input:focus {
    border-color: #ad1457;
}

.login-btn {
    width: 100%;
    padding: 13px;
    background: #ad1457;
    color: white;
    border: none;
    border-radius: 7px;
    font-size: 16px;
    cursor: pointer;
}

.login-btn:hover {
    background: #880e4f;
}

.error {
    color: red;
    text-align: center;
    margin-bottom: 15px;
}

.register-link {
    text-align: center;
    margin-top: 20px;
    font-size: 14px;
}

.register-link a {
    color: #ad1457;
    text-decoration: none;
    font-weight: bold;
}

.back-home {
    text-align: center;
    margin-top: 15px;
}

.back-home a {
    color: #555;
    text-decoration: none;
}
</style>

</head>

<body>

<div class="login-container">

    <h2>Welcome Back!</h2>

    <p class="subtitle">Login to your Fashion Store account</p>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error">
            <%= request.getAttribute("error") %>
        </p>
    <% } %>

    <form action="${pageContext.request.contextPath}/login"
          method="post">

        <div class="input-group">
            <label>Email Address</label>
            <input type="email"
                   name="email"
                   placeholder="Enter your email"
                   required>
        </div>

        <div class="input-group">
            <label>Password</label>
            <input type="password"
                   name="password"
                   placeholder="Enter your password"
                   required>
        </div>

        <button type="submit" class="login-btn">
            Login
        </button>

    </form>

    <div class="register-link">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register">
            Register
        </a>
    </div>

    <div class="back-home">
        <a href="${pageContext.request.contextPath}/home">
            ← Back to Home
        </a>
    </div>

</div>

</body>
</html>

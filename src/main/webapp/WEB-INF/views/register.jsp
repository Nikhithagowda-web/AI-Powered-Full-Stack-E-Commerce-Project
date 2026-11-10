<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>Register - Fashion Store</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial,sans-serif}
body{background:#1e1033;color:white}
.header{background:#150826;padding:14px 60px;display:flex;justify-content:space-between;align-items:center}
.header a{color:white;text-decoration:none;margin-left:15px;font-size:13px}
.box{display:flex;justify-content:center;margin-top:50px}
.card{background:#241243;padding:35px;border-radius:14px;width:380px;text-align:center}
.card h2{margin-bottom:20px}
.card input{width:100%;padding:12px;margin:8px 0;border-radius:20px;border:none;outline:none;background:#3a2366;color:white}
.card input::placeholder{color:#b9a8d9}
.btn{background:#7ee8fa;border:none;padding:12px;border-radius:20px;font-weight:bold;cursor:pointer;width:100%;margin-top:12px}
.card a{color:#7ee8fa;text-decoration:none;font-size:13px}
.err{color:#ff8a8a;font-size:13px;margin:10px 0}
.success{color:#7ee8fa;font-size:13px;margin:10px 0}
</style>
</head>
<body>

<div class="header">
<h2>Fashion Store</h2>
<div>
<a href="products">Home</a>
<a href="products">Products</a>
<a href="#">Cart</a>
<a href="login">Login</a>
<a href="register">Register</a>
</div>
</div>

<div class="box">
<div class="card">
<h2>Create Account</h2>

<% String error = (String) request.getAttribute("error");
   if(error != null){ %>
<p class="err"><%= error %></p>
<% } %>

<form action="register" method="post">
<input type="text" name="name" placeholder="Full Name" required>
<input type="email" name="email" placeholder="Email" required>
<input type="password" name="password" placeholder="Password" required>
<button class="btn" type="submit">Register</button>
</form>

<p style="margin-top:
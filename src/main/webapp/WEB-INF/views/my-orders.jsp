<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders - Fashion Store</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial,sans-serif}
body{background:#15152b;color:#fff}
a{color:#fff;text-decoration:none}
.navbar{background:#1a1a2e;padding:14px 60px;display:flex;justify-content:space-between;align-items:center}
.navbar a{margin-left:22px;color:#ccc;font-size:14px}
.container{padding:30px 60px}
h1{margin-bottom:20px}
.order-card{background:#1e1e38;border-radius:14px;padding:20px;margin-bottom:20px}
.order-header{display:flex;justify-content:space-between;margin-bottom:15px;padding-bottom:10px;border-bottom:1px solid #333}
.badge{background:#22c55e;color:#fff;padding:4px 12px;border-radius:20px;font-size:12px}
.item{display:flex;gap:15px;align-items:center;margin-bottom:10px}
.item img{width:60px;height:60px;object-fit:cover;border-radius:8px;background:#333}
.empty{background:#1e1e38;border-radius:14px;padding:20px;text-align:center}
.btn{background:#e2e8f0;color:#0f172a;border:none;padding:10px 22px;border-radius:20px;font-weight:bold;cursor:pointer;margin-top:15px}
</style>
</head>
<body>
<div class="navbar">
  <div style="font-weight:bold;font-size:20px">Fashion Store</div>
  <div>
    <a href="${pageContext.request.contextPath}/home">Home</a>
    <a href="${pageContext.request.contextPath}/products">Products</a>
    <a href="${pageContext.request.contextPath}/cart">Cart</a>
    <a href="${pageContext.request.contextPath}/my-orders">My Orders</a>
  </div>
</div>
<div class="container">
  <h1>My Orders</h1>

  <c:if test="${empty orders}">
    <div class="empty">
      <h3>No orders yet</h3>
      <p style="color:#9a9ab5;margin-top:8px">You haven't placed any orders yet.</p>
      <a href="${pageContext.request.contextPath}/products"><button class="btn">Shop Now</button></a>
    </div>
  </c:if>

  <c:forEach var="o" items="${orders}">
    <div class="order-card">
      <div class="order-header">
        <div><b>Order #${o.id}</b><br><small style="color:#9a9ab5">${o.date} | ${o.paymentMethod} | ${o.address}</small></div>
        <div style="text-align:right"><span class="badge">${o.status}</span><br><b style="display:block;margin-top:6px">₹${o.total}</b></div>
      </div>
      <c:forEach var="it" items="${o.items}">
        <div class="item">
          <c:if test="${not empty it.image}"><img src="${pageContext.request.contextPath}/${it.image}"></c:if>
          <div style="flex:1"><b>${it.name}</b><br><small style="color:#9a9ab5">Qty: ${it.quantity}</small></div>
          <b>₹${it.price}</b>
        </div>
      </c:forEach>
    </div>
  </c:forEach>

</div>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" import="java.util.*" %>
<html><head><title>Fashion Store - Order Confirmation</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Arial, sans-serif; }
body { background: linear-gradient(135deg, #1e1033 0%, #2d1b4e 50%, #3d2a6b 100%); min-height:100vh; color:white; }
.navbar { background:#160b2e; padding:16px 40px; display:flex; align-items:center; justify-content:space-between; }
.navbar .logo { font-size:22px; font-weight:800; }
.search-box { display:flex; background:white; border-radius:25px; overflow:hidden; width:380px; }
.search-box input { border:none; outline:none; padding:10px 18px; flex:1; }
.search-box button { background:#7dd3fc; border:none; padding:10px 22px; cursor:pointer; }
.nav-links { display:flex; gap:25px; }
.nav-links a { color:white; text-decoration:none; font-size:14px; font-weight:600; }
.container { max-width:800px; margin:0 auto; padding:35px 20px 60px; text-align:center; }
.check-circle { width:58px; height:58px; background:#22c55e; border-radius:50%; display:flex; align-items:center; justify-content:center; font-size:30px; font-weight:800; margin:0 auto 18px; }
.container h1 { font-size:30px; margin-bottom:8px; }
.subtitle { color:#c4b5e0; font-size:14px; margin-bottom:28px; }
.details-box { background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:16px; padding:20px 25px; text-align:left; margin-bottom:18px; }
.row { display:flex; justify-content:space-between; padding:13px 0; border-bottom:1px solid rgba(255,255,255,0.12); font-size:14px; }
.row:last-child { border-bottom:none; }
.row .value { font-weight:700; text-align:right; }
.delivery-box { background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:16px; padding:20px 25px; text-align:left; }
.delivery-box h2 { font-size:20px; margin-bottom:12px; }
.delivery-box p { font-size:14px; line-height:1.7; }
.items-box { background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:16px; padding:20px 25px; text-align:left; margin-bottom:18px; }
.items-box h2 { font-size:18px; margin-bottom:10px; }
.items-box p { font-size:14px; padding:6px 0; border-bottom:1px solid rgba(255,255,255,0.08); }
.btns { display:flex; gap:15px; justify-content:center; margin-top:25px; flex-wrap:wrap; }
.btn-primary { background:#7dd3fc; color:#0f172a; padding:13px 28px; border-radius:25px; font-weight:800; text-decoration:none; font-size:14px; }
.btn-secondary { background:transparent; border:1px solid rgba(255,255,255,0.4); color:white; padding:13px 28px; border-radius:25px; font-weight:700; text-decoration:none; font-size:14px; }
</style></head><body>
<div class="navbar"><div class="logo">Fashion Store</div><div class="search-box"><input type="text" placeholder="Search for fashion products..."><button>&#128269;</button></div><div class="nav-links"><a href="${pageContext.request.contextPath}/home.jsp">Home</a><a href="${pageContext.request.contextPath}/products">Products</a><a href="${pageContext.request.contextPath}/cart">Cart</a><a href="${pageContext.request.contextPath}/login.jsp">Login</a></div></div>
<div class="container">
<div class="check-circle">&#10003;</div><h1>Order Placed Successfully</h1><p class="subtitle">Your order has been placed successfully and is now being processed.</p>
<div class="details-box">
<div class="row"><span>Order ID</span><span class="value"><%= request.getAttribute("orderId") %></span></div>
<div class="row"><span>Order Date</span><span class="value"><%= request.getAttribute("orderDate") %></span></div>
<div class="row"><span>Payment Method</span><span class="value"><%= request.getAttribute("paymentMethod") %></span></div>
<div class="row"><span>Status</span><span class="value"><%= request.getAttribute("status") %></span></div>
<div class="row"><span>Total Amount</span><span class="value">Rs. <%= request.getAttribute("totalAmount") != null ? String.format("%.2f", (Double) request.getAttribute("totalAmount")) : "0.00" %></span></div>
</div>
<%
List<Map<String, Object>> items = (List<Map<String, Object>>) request.getAttribute("orderItems");
if (items != null && !items.isEmpty()) {
%><div class="items-box"><h2>Items Ordered</h2><% for (Map<String, Object> it : items) { %><p><%= it.get("name") %> - Qty: <%= it.get("quantity") %> - Rs. <%= it.get("price") %></p><% } %></div><% } %>
<div class="delivery-box"><h2>Delivery Details</h2><p><%= request.getAttribute("customerName") %><br><%= request.getAttribute("customerPhone") %><br><%= request.getAttribute("customerAddress") %><br><%= request.getAttribute("customerCity") %>, <%= request.getAttribute("customerState") %></p></div>
<div class="btns"><a href="${pageContext.request.contextPath}/products" class="btn-primary">Continue Shopping</a><a href="${pageContext.request.contextPath}/home.jsp" class="btn-secondary">Go to Home</a></div>
</div></body></html>
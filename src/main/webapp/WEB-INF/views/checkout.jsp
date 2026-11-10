<%@ page contentType="text/html;charset=UTF-8" %>
<html><head><title>Checkout</title>
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Segoe UI', Arial, sans-serif; }
body { background: linear-gradient(135deg, #1e1033 0%, #2d1b4e 50%, #3d2a6b 100%); min-height:100vh; color:white; }
.navbar { background:#160b2e; padding:16px 40px; display:flex; align-items:center; justify-content:space-between; }
.navbar .logo { font-size:22px; font-weight:800; }
.nav-links { display:flex; gap:25px; }
.nav-links a { color:white; text-decoration:none; font-size:14px; font-weight:600; }
.box { max-width:600px; margin:35px auto; background: rgba(255,255,255,0.08); border:1px solid rgba(255,255,255,0.12); border-radius:16px; padding:25px; }
.box h1 { margin-bottom:20px; }
label { font-size:14px; }
input, textarea, select { width:100%; padding:11px; margin:6px 0 15px; border-radius:10px; border:1px solid rgba(255,255,255,0.2); background:#2a1a4a; color:white; outline:none; }
button { background:#7dd3fc; color:#0f172a; padding:13px; width:100%; border:none; border-radius:25px; font-weight:800; cursor:pointer; }
</style></head><body>
<div class="navbar"><div class="logo">Fashion Store</div><div class="nav-links"><a href="${pageContext.request.contextPath}/home.jsp">Home</a><a href="${pageContext.request.contextPath}/products">Products</a><a href="${pageContext.request.contextPath}/cart">Cart</a></div></div>
<div class="box"><h1>Checkout</h1>
<% String err = (String) request.getAttribute("error"); if (err != null) { %><p style="color:#fda4af;margin-bottom:15px;"><%= err %></p><% } %>
<form action="${pageContext.request.contextPath}/checkout" method="post">
<label>Full Name</label><input type="text" name="name" required>
<label>Phone</label><input type="text" name="phone" required>
<label>Email</label><input type="email" name="email" required>
<label>Address</label><textarea name="address" required></textarea>
<label>City</label><input type="text" name="city" required>
<label>State</label><input type="text" name="state" required>
<label>Payment</label><select name="paymentMethod"><option value="COD">Cash on Delivery</option><option value="UPI">UPI</option><option value="Card">Card</option></select>
<button type="submit">Place Order</button>
</form></div></body></html>
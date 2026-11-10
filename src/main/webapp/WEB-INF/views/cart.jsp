<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%
    List<Map<String,Object>> cart = (List<Map<String,Object>>) session.getAttribute("cart");
    if(cart == null) cart = new ArrayList<>();
    double total = 0;
    for(Map<String,Object> item : cart){
        double p = 0; int q = 1;
        try{ p = Double.parseDouble(String.valueOf(item.get("price"))); }catch(Exception e){}
        try{ q = Integer.parseInt(String.valueOf(item.get("quantity"))); }catch(Exception e){}
        total += p*q;
    }
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Fashion Store - Cart</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Segoe UI',Arial,sans-serif}
body{background:#2d1b4e;color:white}
.navbar{background:#160b2e;padding:16px 40px;display:flex;justify-content:space-between;align-items:center}
.navbar .logo{font-size:22px;font-weight:800}
.nav-links{display:flex;gap:25px}
.nav-links a{color:white;text-decoration:none;font-size:14px;font-weight:600}
.container{max-width:1100px;margin:0 auto;padding:30px 20px 60px}
.container h1{font-size:32px}
.container p.sub{color:#c4b5e0;font-size:14px;margin:8px 0 25px}
.main{display:flex;gap:25px;align-items:flex-start}
.left{flex:1;display:flex;flex-direction:column;gap:18px}
.card{background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.12);border-radius:16px;padding:16px;display:flex;gap:18px;align-items:center}
.card img{width:110px;height:110px;object-fit:cover;border-radius:12px;background:white}
.card .info{flex:1}
.card .brand{color:#60a5fa;font-size:12px;font-weight:700}
.card h3{font-size:19px;margin:3px 0}
.card .size{font-size:13px;color:#c4b5e0}
.card .price{font-weight:700;margin-top:6px}
.qty-row{display:flex;gap:10px;align-items:center;margin-top:10px}
.qty-row input{width:50px;padding:8px;border:none;border-radius:8px;background:#3b2666;color:white;text-align:center}
.btn-update{background:#22d3ee;border:none;padding:8px 18px;border-radius:20px;font-weight:700;cursor:pointer}
.btn-remove{background:none;border:none;color:#e9e0ff;cursor:pointer;font-weight:600}
.subtotal{text-align:right;min-width:110px}
.subtotal small{color:#60a5fa;font-size:11px}
.subtotal b{font-size:16px}
.summary{width:300px;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.12);border-radius:16px;padding:20px}
.summary h3{font-size:19px;margin-bottom:15px}
.summary .row{display:flex;justify-content:space-between;margin:12px 0}
.btn-checkout{background:#22d3ee;border:none;width:100%;padding:13px;border-radius:25px;font-weight:800;cursor:pointer;margin-top:10px}
.btn-continue{display:block;text-align:center;color:white;text-decoration:none;margin-top:12px;font-size:13px}
.empty{text-align:center;padding:60px;color:#c4b5e0}
.empty a{color:#22d3ee}
</style>
</head>
<body>
<div class="navbar"><div class="logo">Fashion Store</div><div class="nav-links"><a href="home">Home</a><a href="products">Products</a><a href="cart">Cart</a><a href="login">Login</a></div></div>
<div class="container">
<h1>Your Shopping Cart</h1>
<p class="sub">Review your selected items before checkout.</p>
<% if(cart.isEmpty()){ %>
<div class="empty"><h2>Your cart is empty</h2><br><a href="products">Continue Shopping</a></div>
<% } else { %>
<div class="main">
<div class="left">
<% for(int i=0;i<cart.size();i++){ Map<String,Object> it = cart.get(i);
   String name = String.valueOf(it.getOrDefault("productName", it.getOrDefault("name","Product")));
   String brand = String.valueOf(it.getOrDefault("brand","H&M"));
   String img = String.valueOf(it.getOrDefault("image","images/tshirt.jpg"));
   String size = String.valueOf(it.getOrDefault("size","L"));
   double price = 0; int qty=1;
   try{ price = Double.parseDouble(String.valueOf(it.get("price"))); }catch(Exception e){}
   try{ qty = Integer.parseInt(String.valueOf(it.get("quantity"))); }catch(Exception e){}
   // FIX: If name is Product 8 / Product 9, correct it from ID
   String pid = String.valueOf(it.getOrDefault("productId", it.getOrDefault("id","")));
   if(name.equals("Product 8")||pid.equals("8")){ name="Sunglasses"; brand="RAY-BAN"; img="images/sunglasses2.jpg"; price=1299; }
   if(name.equals("Product 9")||pid.equals("9")){ name="Unisex Cap"; brand="Puma"; img="images/cap.jpg"; price=599; }
   if(name.equals("Product 5")||pid.equals("5")){ name="Green Hoodie"; brand="H&M"; img="images/hoodie.jpg"; price=1899; }
%>
<div class="card">
<img src="<%= img %>" onerror="this.src='images/tshirt.jpg'">
<div class="info">
<div class="brand"><%= brand %></div>
<h3><%= name %></h3>
<div class="size">Size: <%= size %></div>
<div class="price">Rs. <%= String.format("%.2f", price) %></div>
<div class="qty-row">
<span>Qty</span>
<form action="cart" method="post" style="display:flex;gap:8px;align-items:center">
<input type="hidden" name="action" value="update">
<input type="hidden" name="index" value="<%= i %>">
<input type="hidden" name="productId" value="<%= pid %>">
<input type="number" name="quantity" value="<%= qty %>" min="1">
<button class="btn-update">Update</button>
</form>
<form action="cart" method="post"><input type="hidden" name="action" value="remove"><input type="hidden" name="index" value="<%= i %>"><input type="hidden" name="productId" value="<%= pid %>"><button class="btn-remove">Remove</button></form>
</div>
</div>
<div class="subtotal"><small>Subtotal</small><br><b>Rs. <%= String.format("%.2f", price*qty) %></b></div>
</div>
<% } %>
</div>
<div class="summary">
<h3>Order Summary</h3>
<div class="row"><span>Total</span><b>Rs. <%= String.format("%.2f", total) %></b></div>
<form action="checkout" method="get"><button class="btn-checkout">Proceed to Checkout</button></form>
<a class="btn-continue" href="products">Continue Shopping</a>
</div>
</div>
<% } %>
</div>
</body>
</html>
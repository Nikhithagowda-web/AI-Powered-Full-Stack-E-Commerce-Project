<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,com.fashionstore.model.Product" %>
<%
List<Product> products = (List<Product>)request.getAttribute("products");
if(products==null) products=new ArrayList<>();
String ctx = request.getContextPath();
String category = (String)request.getAttribute("category");
if(category==null) category="";
String search = (String)request.getAttribute("search");
if(search==null) search="";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fashion Collection - Fashion Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial, sans-serif}
body{background:#2a0a5e;color:#fff}
.topbar{background:#1b0b38;display:flex;justify-content:space-between;align-items:center;padding:12px 22px}
.topbar b{font-size:15px}
.topbar .links a{color:#fff;text-decoration:none;font-size:12px;margin-left:16px}
.wrap{max-width:1100px;margin:auto;padding:20px}
.title{text-align:center}
.title h2{font-size:22px}
.title p{font-size:11px;color:#b9a8dd;margin-top:4px}
.main{display:flex;gap:16px;margin-top:20px;align-items:flex-start}
.filters{flex:0 0 260px;background:#3a1a6d;border-radius:12px;padding:16px}
.filters h3{font-size:15px;margin-bottom:12px}
.filters label{display:block;font-size:11px;margin:12px 0 5px 0}
.filters input,.filters select{width:100%;padding:8px 10px;border:none;border-radius:8px;outline:none;font-size:11px;background:#2a0a5e;color:#fff}
.filters select option{color:#000;background:#fff}
.price-row{display:flex;gap:8px}
.btn-row{display:flex;gap:8px;margin-top:14px}
.apply{background:#fff;color:#000;border:none;padding:7px 14px;border-radius:20px;font-size:11px;cursor:pointer;font-weight:bold}
.clear{background:#0ea5e9;color:#fff;border:none;padding:7px 14px;border-radius:20px;font-size:11px;cursor:pointer}
.prod-area{flex:1}
.prod-area h3{font-size:15px;margin-bottom:12px}
.prod-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:14px}
.prod-card{background:#3a1a6d;border-radius:12px;overflow:hidden}
.prod-card img{width:100%;height:200px;object-fit:cover;background:#fff;display:block}
.prod-info{padding:10px 12px 12px 12px}
.prod-info b{font-size:11px;display:block}
.prod-info small{font-size:10px;color:#b9a8dd}
.prod-info p{font-size:11px;margin:5px 0 10px 0}
.view-btn{background:#fff;color:#000;border:none;width:100%;padding:8px;border-radius:20px;font-size:11px;cursor:pointer;display:block;text-align:center;text-decoration:none;margin-bottom:8px}
.add-btn{background:#00c8e0;color:#000;border:none;width:100%;padding:8px;border-radius:20px;font-size:11px;font-weight:bold;cursor:pointer}
.footer{background:#1b0b38;padding:16px;text-align:center;font-size:10px;color:#8a7ab0;margin-top:20px}
</style>
</head>
<body>
<div class="topbar">
<b>Fashion Store</b>
<div class="links">
<a href="<%=ctx%>/home">Home</a>
<a href="<%=ctx%>/products">Products</a>
<a href="<%=ctx%>/cart">Cart</a>
<a href="<%=ctx%>/login">Login</a>
</div>
</div>

<div class="wrap">
<div class="title">
<h2>Fashion Collection</h2>
<p>Discover styles that match your taste</p>
</div>

<div class="main">
<!-- FILTERS -->
<div class="filters">
<h3>Filters</h3>
<form action="<%=ctx%>/products" method="get">
<label>Search</label>
<input name="search" value="<%=search%>" placeholder="Sunglasses">
<label>Category</label>
<select name="category">
<option value="">All Categories</option>
<option value="Men" <%= "Men".equals(category)?"selected":"" %>>Men</option>
<option value="Women" <%= "Women".equals(category)?"selected":"" %>>Women</option>
<option value="Accessories" <%= "Accessories".equals(category)?"selected":"" %>>Accessories</option>
</select>
<label>Price Range</label>
<div class="price-row">
<div><small>Min Price</small><input name="minPrice" value="0"></div>
<div><small>Max Price</small><input name="maxPrice" value="5000"></div>
</div>
<label>Sort By</label>
<select name="sort">
<option value="">Default</option>
<option value="low">Price: Low to High</option>
<option value="high">Price: High to Low</option>
</select>
<div class="btn-row">
<button class="apply" type="submit">Apply Filters</button>
<a href="<%=ctx%>/products"><button class="clear" type="button">Clear</button></a>
</div>
</form>
</div>

<!-- PRODUCTS -->
<div class="prod-area">
<h3>Products</h3>
<div class="prod-grid">
<% for(Product p: products){ %>
<div class="prod-card">
<a href="<%=ctx%>/product-details?id=<%=p.getId()%>"><img src="<%=ctx%>/images/<%=p.getImage()%>"></a>
<div class="prod-info">
<b><%=p.getName()%></b>
<small><%=p.getBrand()%></small>
<p>Rs. <%=String.format("%.2f", p.getPrice())%></p>
<a class="view-btn" href="<%=ctx%>/product-details?id=<%=p.getId()%>">View Details</a>
<button class="add-btn" onclick="addCart(<%=p.getId()%>,'<%=p.getName()%>','<%=p.getImage()%>',<%=p.getPrice()%>,'<%=p.getBrand()%>')">Add to Cart</button>
</div>
</div>
<% } %>
</div>
<% if(products.isEmpty()){ %><p style="margin-top:20px;font-size:12px;">No products found.</p><% } %>
</div>
</div>
</div>

<div class="footer">© 2026 Fashion Store. All rights reserved.</div>

<script>
function addCart(id,name,img,price,brand){
  let cart = JSON.parse(localStorage.getItem('cart')||'[]');
  let f = cart.find(x=>x.id==id);
  if(f){ f.qty++; }
  else{ cart.push({id:id,name:name,img:img,price:price,brand:brand,qty:1,size:'M'}); }
  localStorage.setItem('cart',JSON.stringify(cart));
  alert(name + ' added to cart');
}
</script>
</body>
</html>
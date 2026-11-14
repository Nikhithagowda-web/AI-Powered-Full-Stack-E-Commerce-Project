<%@ page import="java.util.*,com.fashionstore.model.Product" %>
<%
List<Product> products = (List<Product>)request.getAttribute("products");
if(products==null) products=new ArrayList<>();
String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<title>Fashion Store</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial, sans-serif}
body{background:#2a0a5e;color:#fff}
.topbar{background:#1b0b38;display:flex;justify-content:space-between;align-items:center;padding:12px 22px;position:sticky;top:0;z-index:10}
.topbar b{font-size:15px;font-weight:bold}
.topbar .links a{color:#fff;text-decoration:none;font-size:12px;margin-left:16px}
.search{display:flex;align-items:center}
.search input{width:300px;padding:7px 14px;border:none;border-radius:20px 0 0 20px;outline:none;font-size:12px}
.search button{background:#4ec9f5;color:#000;border:none;padding:7px 16px;border-radius:0 20px 20px 0;cursor:pointer;font-size:12px;font-weight:bold}
.wrap{max-width:1020px;margin:auto;padding:22px 20px 0 20px}
.hero{background:#3a1a6d;border-radius:14px;display:flex;justify-content:space-between;align-items:center;padding:32px 32px;gap:24px}
.hero-left{flex:1}
.hero-left h1{font-size:32px;line-height:1.15;font-weight:bold}
.hero-left p{font-size:12px;line-height:1.6;color:#d8c8f5;margin:12px 0 18px 0;max-width:360px}
.hero-right{flex:0 0 340px}
.hero-right img{width:100%;height:190px;object-fit:cover;border-radius:10px;display:block}
.shop-btn{background:#7ed6ff;color:#000;text-decoration:none;font-size:12px;font-weight:bold;padding:9px 18px;border-radius:20px;display:inline-block}
h3{font-size:14px;margin:24px 0 12px 0}
.cat-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:16px}
.cat-card{background:#3a1a6d;border-radius:12px;overflow:hidden;text-align:center;padding-bottom:16px}
.cat-card img{width:100%;height:185px;object-fit:cover;display:block;background:#fff}
.cat-card b{display:block;font-size:12px;margin-top:12px}
.cat-card span{display:block;font-size:10px;color:#b9a8dd;margin:3px 0 10px 0}
.explore{background:#7ed6ff;color:#000;text-decoration:none;font-size:11px;font-weight:bold;padding:6px 16px;border-radius:20px;display:inline-block}
.prod-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:16px;padding-bottom:24px}
.prod-card{background:#3a1a6d;border-radius:12px;overflow:hidden;cursor:pointer}
.prod-card img{width:100%;height:230px;object-fit:cover;display:block;background:#fff}
.prod-info{padding:12px 12px 14px 12px}
.prod-info b{font-size:11px;font-weight:bold;display:block}
.prod-info p{font-size:11px;margin:4px 0 10px 0;color:#fff}
.add-btn{background:#7ed6ff;color:#000;border:none;width:100%;padding:9px;border-radius:20px;font-size:11px;font-weight:bold;cursor:pointer;display:block;text-align:center;text-decoration:none}
.footer{background:#1b0b38;padding:18px 22px;margin-top:10px}
.footer-top{display:flex;justify-content:space-between;align-items:flex-start;max-width:1020px;margin:auto}
.footer-top b{font-size:12px}
.footer-top p{font-size:11px;color:#b9a8dd;margin-top:3px}
.footer-top a{color:#fff;font-size:11px}
.footer-bottom{text-align:center;font-size:10px;color:#8a7ab0;margin-top:14px}
</style>
</head>
<body>
<div class="topbar">
<b>Fashion Store</b>
<form class="search" action="<%=ctx%>/products" method="get">
<input name="search" placeholder="Search for fashion products...">
<button type="submit">Search</button>
</form>
<div class="links">
<a href="<%=ctx%>/home">Home</a>
<a href="<%=ctx%>/products">Products</a>
<a href="<%=ctx%>/cart">Cart</a>
<a href="<%=ctx%>/login">Login</a>
</div>
</div>
<div class="wrap">
<div class="hero">
<div class="hero-left">
<h1>Trendy Fashion<br>Collection 2026</h1>
<p>Discover the latest styles in fashion. From casual wear to premium outfits, find your perfect look at best prices.</p>
<a class="shop-btn" href="<%=ctx%>/products">Shop Now</a>
</div>
<div class="hero-right">
<img src="<%=ctx%>/images/jacket.jpg">
</div>
</div>
<h3>Shop by Category</h3>
<div class="cat-grid">
<div class="cat-card">
<img src="<%=ctx%>/images/dress.jpg">
<b>Women</b>
<span>Fashion products for women</span>
<a class="explore" href="<%=ctx%>/products?category=Women">Explore</a>
</div>
<div class="cat-card">
<img src="<%=ctx%>/images/jacket.jpg">
<b>Men</b>
<span>Fashion products for men</span>
<a class="explore" href="<%=ctx%>/products?category=Men">Explore</a>
</div>
<div class="cat-card">
<img src="<%=ctx%>/images/cap.jpg">
<b>Accessories</b>
<span>Fashion accessories</span>
<a class="explore" href="<%=ctx%>/products?category=Accessories">Explore</a>
</div>
</div>
<h3>Latest Products</h3>
<div class="prod-grid">
<% for(Product p: products){ %>
<div class="prod-card">
<a href="<%=ctx%>/product-details?id=<%=p.getId()%>">
<img src="<%=ctx%>/images/<%=p.getImage()%>">
</a>
<div class="prod-info">
<b><%=p.getName()%></b>
<p>Rs. <%=String.format("%.2f", p.getPrice())%></p>
<button class="add-btn" onclick="addCart(<%=p.getId()%>,'<%=p.getName()%>','<%=p.getImage()%>',<%=p.getPrice()%>,'<%=p.getBrand()%>')">Add to Cart</button>
</div>
</div>
<% } %>
</div>
</div>
<div class="footer">
<div class="footer-top">
<div>
<b>Fashion Store</b>
<p>Your one-stop destination for stylish fashion</p>
</div>
<a href="#">Privacy Policy</a>
</div>
<div class="footer-bottom">© 2026 Fashion Store. All rights reserved.</div>
</div>
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
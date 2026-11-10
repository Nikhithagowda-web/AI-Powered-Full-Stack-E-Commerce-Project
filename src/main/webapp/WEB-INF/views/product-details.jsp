<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fashion Store - Product Details</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial,sans-serif}
body{background:#15152b;color:#fff}
a{color:#fff;text-decoration:none}
.navbar{background:#1a1a2e;padding:14px 60px;display:flex;align-items:center;justify-content:space-between}
.logo{font-size:20px;font-weight:bold}
.search-box{display:flex;background:#2a2a45;border-radius:20px;overflow:hidden}
.search-box input{background:transparent;border:none;outline:none;color:#fff;padding:9px 15px;width:280px}
.search-box input::placeholder{color:#9a9ab5}
.search-box button{background:#38bdf8;border:none;color:#fff;padding:9px 18px;border-radius:20px;cursor:pointer;font-weight:bold}
.nav-links a{margin-left:22px;font-size:14px;color:#ccc}
.nav-links a.active{color:#fff}
.container{padding:30px 60px 40px}
.detail{background:#1e1e38;border-radius:14px;display:flex;gap:40px;padding:30px}
.detail-left{width:45%}
.detail-left img{width:100%;height:420px;object-fit:contain;background:#fff;border-radius:12px;padding:10px}
.detail-right{flex:1}
.detail-right .cat{color:#9a9ab5;font-size:13px;margin-bottom:6px}
.detail-right h1{font-size:30px;margin-bottom:12px}
.detail-right .price{font-size:24px;font-weight:bold;margin-bottom:18px}
.detail-right h3{font-size:15px;margin:16px 0 8px}
.detail-right p{color:#ccc;line-height:1.6;font-size:14px}
.sizes{display:flex;gap:10px;flex-wrap:wrap;margin-bottom:6px}
.size-btn{background:#2a2a45;color:#fff;border:1px solid #3a3a5c;padding:8px 14px;border-radius:8px;cursor:pointer;font-size:13px;font-weight:bold}
.size-btn.active{background:#e2e8f0;color:#0f172a;border-color:#e2e8f0}
.size-note{font-size:12px;color:#9a9ab5;margin-bottom:10px}
.qty-box{margin:10px 0 20px}
.qty-box label{font-size:13px;color:#ccc;display:block;margin-bottom:6px}
.qty-box input{width:70px;background:#2a2a45;border:1px solid #3a3a5c;color:#fff;padding:9px;border-radius:8px;text-align:center;font-size:15px;outline:none}
.btn-row{display:flex;gap:12px}
.btn-add{background:#e2e8f0;color:#0f172a;border:none;padding:12px 28px;border-radius:20px;font-weight:bold;cursor:pointer;font-size:14px}
.btn-back{background:#3a3a5c;color:#fff;border:none;padding:12px 24px;border-radius:20px;cursor:pointer;font-size:14px}
.related{margin-top:30px}
.related h2{font-size:18px;margin-bottom:18px}
.related-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:18px}
.rel-card{background:#1e1e38;border-radius:12px;overflow:hidden;cursor:pointer}
.rel-card img{width:100%;height:180px;object-fit:contain;background:#fff;padding:5px}
.rel-card-body{padding:12px}
.rel-card-body h4{font-size:14px;margin-bottom:4px}
.rel-card-body p{font-size:12px;color:#9a9ab5}
.rel-card-body .rprice{font-weight:bold;margin-top:6px;font-size:14px}
.error-box{background:#3b1a1a;border:1px solid #ff5555;padding:20px;border-radius:12px;text-align:center}
</style>
</head>
<body>

<div class="navbar">
  <div class="logo">Fashion Store</div>
  <div class="search-box"><input type="text" placeholder="Search for fashion products..."><button>Search</button></div>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/home">Home</a>
    <a href="${pageContext.request.contextPath}/products" class="active">Products</a>
    <a href="${pageContext.request.contextPath}/cart">Cart</a>
    <a href="${pageContext.request.contextPath}/login">Login</a>
  </div>
</div>

<div class="container">

<c:choose>
<c:when test="${empty product}">
  <div class="error-box">
    <h2>Product Not Found</h2>
    <p style="margin:10px 0">No product found for this ID. Please go back and try again.</p>
    <br>
    <a href="${pageContext.request.contextPath}/products"><button class="btn-back">Back to Products</button></a>
  </div>
</c:when>
<c:otherwise>

<div class="detail">
  <div class="detail-left">
    <img src="${pageContext.request.contextPath}/images/${product.image}" onerror="this.src='${pageContext.request.contextPath}/${product.image}'">
  </div>

  <div class="detail-right">
    <div class="cat">${product.category}</div>
    <h1>${product.name}</h1>
    <div class="price">₹ ${product.price}</div>

    <h3>Description</h3>
    <p>${product.description}</p>

    <h3>Available Sizes</h3>
    <div class="sizes" id="sizeBox">
      <c:choose>
        <c:when test="${not empty variants}">
          <c:forEach var="v" items="${variants}">
            <button type="button" class="size-btn" onclick="selectSize(this,'${v.size}')">${v.size}</button>
          </c:forEach>
        </c:when>
        <c:otherwise>
          <button type="button" class="size-btn" onclick="selectSize(this,'10-11Y')">10-11Y</button>
          <button type="button" class="size-btn" onclick="selectSize(this,'4-5Y')">4-5Y</button>
          <button type="button" class="size-btn" onclick="selectSize(this,'6-7Y')">6-7Y</button>
          <button type="button" class="size-btn" onclick="selectSize(this,'8-9Y')">8-9Y</button>
        </c:otherwise>
      </c:choose>
    </div>
    <div class="size-note">Select a size and quantity to continue</div>

    <form action="${pageContext.request.contextPath}/cart" method="post" onsubmit="return checkSize()">
      <input type="hidden" name="action" value="add">
      <input type="hidden" name="productId" value="${product.id}">
      <input type="hidden" name="size" id="selectedSize" value="">
      <div class="qty-box">
        <label>Quantity</label>
        <input type="number" name="quantity" id="qty" value="1" min="1" max="10">
      </div>
      <div class="btn-row">
        <button type="submit" class="btn-add">Add to Cart</button>
        <a href="${pageContext.request.contextPath}/products"><button type="button" class="btn-back">Back to Products</button></a>
      </div>
    </form>
  </div>
</div>

<div class="related">
  <h2>Related Products</h2>
  <c:choose>
    <c:when test="${not empty relatedProducts}">
      <div class="related-grid">
        <c:forEach var="rp" items="${relatedProducts}">
          <div class="rel-card" onclick="window.location.href='${pageContext.request.contextPath}/product-details?id=${rp.id}'">
            <img src="${pageContext.request.contextPath}/images/${rp.image}" onerror="this.src='${pageContext.request.contextPath}/${rp.image}'">
            <div class="rel-card-body">
              <h4>${rp.name}</h4>
              <p>${rp.category}</p>
              <div class="rprice">₹ ${rp.price}</div>
            </div>
          </div>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
      <div class="related-grid">
        <div class="rel-card" onclick="window.location.href='${pageContext.request.contextPath}/product-details?id=1'"><img src="${pageContext.request.contextPath}/images/hoodie.jpg"><div class="rel-card-body"><h4>Green Hoodie</h4><p>Men</p><div class="rprice">₹ 1899.00</div></div></div>
        <div class="rel-card" onclick="window.location.href='${pageContext.request.contextPath}/product-details?id=2'"><img src="${pageContext.request.contextPath}/images/cap.jpg"><div class="rel-card-body"><h4>Unisex Cap</h4><p>Accessories</p><div class="rprice">₹ 599.00</div></div></div>
        <div class="rel-card" onclick="window.location.href='${pageContext.request.contextPath}/product-details?id=6'"><img src="${pageContext.request.contextPath}/images/sneakers.jpg"><div class="rel-card-body"><h4>Black Sneakers</h4><p>Men</p><div class="rprice">₹ 2499.00</div></div></div>
        <div class="rel-card" onclick="window.location.href='${pageContext.request.contextPath}/product-details?id=7'"><img src="${pageContext.request.contextPath}/images/dress.jpg"><div class="rel-card-body"><h4>Floral Dress</h4><p>Women</p><div class="rprice">₹ 1999.00</div></div></div>
      </div>
    </c:otherwise>
  </c:choose>
</div>

</c:otherwise>
</c:choose>

</div>

<script>
var selected = "";
function selectSize(btn, size){
  document.querySelectorAll(".size-btn").forEach(function(b){ b.classList.remove("active"); });
  btn.classList.add("active");
  selected = size;
  document.getElementById("selectedSize").value = size;
}
function checkSize(){
  if(selected === ""){
    alert("Please select a size first!");
    return false;
  }
  return true;
}
window.onload = function(){
  var first = document.querySelector(".size-btn");
  if(first){ first.click(); }
};
</script>

</body>
</html>
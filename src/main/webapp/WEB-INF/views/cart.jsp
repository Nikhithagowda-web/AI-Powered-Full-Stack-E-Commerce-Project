<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Fashion Store - Cart</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:Arial}
body{background:linear-gradient(180deg,#1a1a2e,#302b63,#1e1b4b);color:#fff;min-height:100vh}
.topbar{background:#1e1b4b;padding:15px 20px;display:flex;justify-content:center}
.search-box{display:flex;width:100%;max-width:600px;background:#fff;border-radius:25px;overflow:hidden}
.search-box input{flex:1;padding:12px 18px;border:none;outline:none;font-size:15px;color:#333}
.search-box button{padding:12px 25px;border:none;background:#00c2ff;color:#000;font-weight:bold;cursor:pointer}
.wrap{max-width:1150px;margin:auto;padding:25px 20px}
.wrap h1{font-size:32px}
.wrap .sub{color:#c9c9ff;margin:5px 0 25px}
a{color:#fff;text-decoration:none}
/* MAIN - LEFT + RIGHT */
.main{display:flex;gap:25px;align-items:flex-start}
.left{flex:1;display:flex;flex-direction:column;gap:18px}
.card{background:linear-gradient(135deg,#3a3a9e,#25256e);border-radius:15px;padding:18px;display:flex;gap:18px}
.card img{width:110px;height:110px;object-fit:contain;background:#fff;border-radius:10px;padding:5px;flex-shrink:0}
.card-info{flex:1}
.card-info .brand{color:#00e5ff;font-size:13px;font-weight:bold}
.card-info h3{font-size:20px;margin:3px 0}
.card-info .size{color:#ddd;font-size:14px;margin:3px 0}
.card-info .price{font-weight:bold;margin:5px 0}
.qty-row{display:flex;align-items:center;gap:10px;margin-top:10px}
.qty-row span{font-size:14px}
.qty-row input{width:50px;padding:6px;text-align:center;border:none;border-radius:8px;background:#1e1b4b;color:#fff;font-size:15px}
.update{padding:7px 16px;border:none;border-radius:20px;background:#00e5ff;color:#000;font-weight:bold;cursor:pointer}
.remove{background:none;border:none;color:#fff;cursor:pointer;font-size:14px}
.subtotal{text-align:right;min-width:110px}
.subtotal small{color:#aaa;font-size:11px}
.subtotal b{font-size:16px}
/* RIGHT - ORDER SUMMARY */
.summary{width:300px;background:linear-gradient(180deg,#2e2a8a,#1e1b4b);border-radius:15px;padding:20px;position:sticky;top:20px;flex-shrink:0}
.summary h3{margin-bottom:20px;font-size:19px}
.summary-row{display:flex;justify-content:space-between;margin:15px 0}
.summary-row.total{font-weight:bold;font-size:18px}
.checkout{width:100%;padding:13px;border:none;border-radius:25px;background:#00c2ff;color:#000;font-weight:bold;font-size:15px;cursor:pointer;margin-top:10px}
.continue{width:100%;padding:10px;border:none;background:transparent;color:#fff;cursor:pointer;margin-top:8px}
.empty{text-align:center;padding:60px 0;background:rgba(255,255,255,0.08);border-radius:15px}
@media(max-width:800px){.main{flex-direction:column}.summary{width:100%}}
</style>
</head>
<body>
<div class="topbar">
<div class="search-box">
<input type="text" placeholder="Search products...">
<button onclick="location.href='${pageContext.request.contextPath}/products'">Search</button>
</div>
</div>
<div class="wrap">
<a href="${pageContext.request.contextPath}/products">⬅ Back to Products</a><br><br>
<h1>Your Shopping Cart</h1>
<p class="sub">Review your selected items before checkout.</p>
<div id="cartArea"></div>
</div>
<script>
const ctx = "${pageContext.request.contextPath}";
function loadCart(){
  let cart = JSON.parse(localStorage.getItem('cart') || '[]');
  let area = document.getElementById('cartArea');
  if(cart.length === 0){
    area.innerHTML = '<div class="empty"><h2>Your Cart is Empty!</h2><p style="margin:10px 0;color:#ccc">Add some products to your cart</p><button class="checkout" style="max-width:250px" onclick="location.href=\''+ctx+'/products\'">Shop Now</button></div>';
    return;
  }
  let total = 0;
  let leftHtml = '<div class="left">';
  cart.forEach((item, i) => {
    let sub = item.price * item.qty;
    total += sub;
    let brand = item.brand || "H&M";
    leftHtml += '<div class="card">'
      + '<img src="'+item.img+'">'
      + '<div class="card-info"><div class="brand">'+brand+'</div><h3>'+item.name+'</h3><div class="size">Size: '+(item.size||'Free Size')+'</div><div class="price">Rs. '+item.price+'.00</div>'
      + '<div class="qty-row"><span>Qty</span><input type="number" id="qty'+i+'" value="'+item.qty+'" min="1"><button class="update" onclick="updateQty('+i+')">Update</button><button class="remove" onclick="removeItem('+i+')">Remove</button></div></div>'
      + '<div class="subtotal"><small>Subtotal</small><br><b>Rs. '+sub+'.00</b></div></div>';
  });
  leftHtml += '</div>';
  let rightHtml = '<div class="summary"><h3>Order Summary</h3>'
    + '<div class="summary-row"><span>Total</span><span>Rs. '+total+'.00</span></div>'
    + '<button class="checkout" onclick="checkout()">Proceed to Checkout</button>'
    + '<button class="continue" onclick="location.href=\''+ctx+'/products\'">Continue Shopping</button></div>';
  area.innerHTML = '<div class="main">' + leftHtml + rightHtml + '</div>';
}
function updateQty(i){
  let cart = JSON.parse(localStorage.getItem('cart') || '[]');
  let v = Number(document.getElementById('qty'+i).value);
  if(v < 1) v = 1;
  cart[i].qty = v;
  localStorage.setItem('cart', JSON.stringify(cart));
  loadCart();
  alert("Quantity Updated!");
}
function removeItem(i){
  let cart = JSON.parse(localStorage.getItem('cart') || '[]');
  cart.splice(i,1);
  localStorage.setItem('cart', JSON.stringify(cart));
  loadCart();
}
function checkout(){
  let cart = JSON.parse(localStorage.getItem('cart') || '[]');
  if(cart.length===0){ alert("Cart is empty!"); return; }
  alert("Order Placed! Thank you for shopping!");
  localStorage.removeItem('cart');
  loadCart();
}
loadCart();
</script>
</body>
</html>
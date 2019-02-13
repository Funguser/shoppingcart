<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Item Detail</title>

      <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
      <link href="${cp}/css/style.css" rel="stylesheet">

      <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
      <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
      <script src="${cp}/js/layer.js" type="text/javascript"></script>

    <!--[if lt IE 9]>
      <script src="${cp}/js/html5shiv.min.js"></script>
      <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>

    <jsp:include page="include/header.jsp"/>


    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-1 col-md-1"></div>
            <div class="col-sm-10 col-md-10">
                <h1>${productDetail.name}</h1>
                <hr/>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-1 col-md-1"></div>
            <div class="col-sm-5 col-md-5">
                <img class="detail-img" src="${cp}/img/tmp.jpg">
            </div>
            <div class="col-sm-5 col-md-5 detail-x">
                <table class="table table-striped">
                    <tr>
                        <th>Item Name</th>
                        <td>${productDetail.name}</td>
                    </tr>
                    <tr>
                        <th>Item Price</th>
                        <td>${productDetail.price}</td>
                    </tr>
                    <tr>
                        <th>Item Description</th>
                        <td>${productDetail.description}</td>
                    </tr>
                    <tr>
                        <th>Item Remaining</th>
                        <td>${productDetail.counts}</td>
                    </tr>
                    <tr>
                        <th>Number to buy</th>
                        <td>
                            <div class="btn-group" role="group">
                                <button type="button" class="btn btn-default" onclick="subCounts()">-</button>
                                <button id="productCounts" type="button" class="btn btn-default">1</button>
                                <button type="button" class="btn btn-default" onclick="addCounts(1)">+</button>
                            </div>
                        </td>
                    </tr>
                </table>
                <div class="row">
                    <div class="col-sm-1 col-md-1 col-lg-1"></div>
                    <button class="btn btn-danger btn-lg col-sm-4 col-md-4 col-lg-4" onclick="addToShoppingCar(${productDetail.id})">Add to Cart</button>
                    <div class="col-sm-2 col-md-2 col-lg-2"></div>
                    <button  class="btn btn-danger btn-lg col-sm-4 col-md-4 col-lg-4" onclick="buyConfirm(${productDetail.id})">Buy</button>

                </div>
            </div>
        </div>
    </div>


    <jsp:include page="include/foot.jsp"/>
  <script type="text/javascript">
      var token = $("meta[name='_csrf']").attr("content");
      var header = $("meta[name='_csrf_header']").attr("content");


      function addToShoppingCar(productId) {
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          var shoppingDetail = {};
          shoppingDetail.userId = ${currentUser.id};
          shoppingDetail.productId = productId;
          shoppingDetail.counts = counts;
          var addResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/addShoppingCar',
              data : shoppingDetail,
              dataType : 'json',
              beforeSend : function(xhr) {
                  xhr.setRequestHeader(header, token);
              },
              success : function(result) {
                  addResult = result.result;
              },
              error : function(result) {
                  layer.alert('Search User Error');
              }
          });
          if(addResult == "success") {
              layer.confirm('Go to Cart?', {icon: 1, title:'Add Success',btn:['Go to Cart','Continue Browsing']},
                      function(){
                          window.location.href = "${cp}/shopping_car";
                      },
                      function(index){
                        layer.close(index);}
              );
          }
      }
      function subCounts() {
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          if(counts>=2)
              counts--;
          productCounts.innerHTML = counts;
      }

      function addCounts() {
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          if(counts<${productDetail.counts})
              counts++;
          productCounts.innerHTML = counts;
      }

      function buyConfirm(productId) {
          var userDetail = getUserDetail(${currentUser.id});
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          var product = getProductById(productId);
          var html = '<div class="col-sm-1 col-md-1 col-lg-1"></div>'+
                  '<div class="col-sm-10 col-md-10 col-lg-10">'+
                  '<table class="table confirm-margin">'+
                  '<tr>'+
                  '<th>Item Name: </th>'+
                  '<td>'+product.name+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Item Price: </th>'+
                  '<td>'+product.price+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Item Number: </th>'+
                  '<td>'+counts+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Total Price: </th>'+
                  '<td>'+counts*product.price+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Address: </th>'+
                  '<td>'+userDetail.address+'</td>'+
                  '</tr>'+
                  '<tr>'+
                  '<th>Contact Number: </th>'+
                  '<td>'+userDetail.phoneNumber+'</td>'+
                  '</tr>'+
                  '</table>'+
                  '<div class="row">'+
                  '<div class="col-sm-4 col-md-4 col-lg-4"></div>'+
                  '<button class="btn btn-danger col-sm-4 col-md-4 col-lg-4" onclick="addToShoppingRecords('+productId+')">Confirm to buy</button>'+
                  '</div>'+
                  '</div>';
          layer.open({
              type:1,
              title:'Please Confirm your Order: ',
              content:html,
              area:['650px','350px'],
          });
      }

      function getUserDetail(id) {
          var userDetail = "";
          var user = {};
          user.id = id;
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/getUserDetailById',
              data : user,
              dataType : 'json',
              beforeSend : function(xhr) {
                  xhr.setRequestHeader(header, token);
              },
              success : function(result) {
                  userDetail = result.result;
              },
              error : function(result) {
                  layer.alert('Error');
              }
          });
          userDetail = JSON.parse(userDetail);
          return userDetail;
      }

      function getProductById(id) {
          var productResult = "";
          var product = {};
          product.id = id;
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/getProductById',
              data : product,
              dataType : 'json',
              beforeSend : function(xhr) {
                  xhr.setRequestHeader(header, token);
              },
              success : function(result) {
                  productResult = result.result;
              },
              error : function(result) {
                  layer.alert('error');
              }
          });
          productResult = JSON.parse(productResult);
          return productResult;
      }

      function addToShoppingRecords(productId) {
          var productCounts = document.getElementById("productCounts");
          var counts = parseInt(productCounts.innerHTML);
          var shoppingRecord = {};
          shoppingRecord.userId = ${currentUser.id};
          shoppingRecord.productId = productId;
          shoppingRecord.counts = counts;
          var buyResult = "";
          $.ajax({
              async : false,
              type : 'POST',
              url : '${cp}/addShoppingRecord',
              data : shoppingRecord,
              dataType : 'json',
              beforeSend : function(xhr) {
                  xhr.setRequestHeader(header, token);
              },
              success : function(result) {
                  buyResult = result.result;
              },
              error : function(result) {
                  layer.alert('Buy Error');
              }
          });
          if(buyResult == "success") {
              layer.confirm('Go to order status?', {icon: 1, title:'Success',btn:['Go to Order','Continue buying']},
                      function(){
                          window.location.href = "${cp}/shopping_record";
                      },
                      function(index){
                          layer.close(index);}
              );
          }
          else if(buyResult == "unEnough"){
              layer.alert("Out to stock")
          }
      }
  </script>
  </body>
</html>
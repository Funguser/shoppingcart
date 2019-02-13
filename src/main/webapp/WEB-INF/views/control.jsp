<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Shopping Cart</title>
    <link href="${cp}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${cp}/css/style.css" rel="stylesheet">

    <script src="${cp}/js/jquery.min.js" type="text/javascript"></script>
    <script src="${cp}/js/ajaxfileupload.js" type="text/javascript"></script>
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>

    <!--[if lt IE 9]>
    <script src="${cp}/js/html5shiv.min.js"></script>
    <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>

<jsp:include page="include/header.jsp"/>
<c:if test="${not empty sessionScope.currentUser}">
    <c:if test="${sessionScope.currentUser.role eq 0}">
        <c:redirect url="/main"/>
    </c:if>
</c:if>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-12 col-sm-offset-1 col-md-10 col-md-offset-2 main">
            <div class="col-md-12">
                <h1><a name="section1">User Information</a></h1>
                <hr/>
                <table class="table table-hover center" id="userTable">
                    <tr>
                        <th> User ID</th>
                        <th> Username</th>
                        <th> Email</th>
                        <th> Are you sure to delete</th>
                    </tr>
                    <c:forEach var="user" items="${sessionScope.allUser}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>
                                <button class="btn btn-primary btn-sm" type="submit" onclick="deleteUser(${user.id})">
                                    Delete
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                </table>
            </div>

            <div class="col-md-12">
                <hr/>
                <h1><a name="section2">Item Information</a></h1>
                <hr/>
                <div class="col-lg-12 col-md-12 col-sm-12" id="productArea">
                    <c:forEach var="product" items="${sessionScope.allProduct}">

                        <div class="col-sm-4 col-md-4 pd-5">
                            <div class="boxes">
                                <div class="big bigimg">
                                    <img src="${cp}/img/tmp.jpg">
                                </div>
                                <p class="font-styles center">${product.name}</p>
                                <p class="pull-left">Price: ${product.price}</p>
                                <p class="pull-right">Remaining: ${product.counts}</p>
                                <div class="row">
                                    <button class="btn btn-primary delete-button" type="submit"
                                            onclick="deleteProduct(${product.id})">Delete Item
                                    </button>
                                </div>
                            </div>

                        </div>

                    </c:forEach>
                </div>
                <br/>
            </div>

            <div class="col-md-12">
                <hr/>
                <h1><a name="section3">Add Item</a></h1>
                <hr/>
                <div class="col-sm-offset-2 col-md-offest-2">
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label for="productName" class="col-sm-2 col-md-2 control-label">Item Name</label>
                            <div class="col-sm-6 col-md-6">
                                <input type="text" class="form-control" id="productName" placeholder="name"
                                       required="required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productDescribe" class="col-sm-2 col-md-2 control-label">Item
                                Description</label>
                            <div class="col-sm-6 col-md-6">
                                <textarea type="text" class="form-control" id="productDescribe"
                                          placeholder="balabalabalabala" required="required"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productPrice" class="col-sm-2 col-md-2 control-label">Item Price</label>
                            <div class="col-sm-6 col-md-6">
                                <input type="number" class="form-control" id="productPrice" placeholder="99.99"
                                       required="required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="productCount" class="col-sm-2 col-md-2 control-label">Item Quantity</label>
                            <div class="col-sm-6 col-md-6">
                                <input type="number" class="form-control" id="productCount" placeholder="100"
                                       required="required"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-6">
                                <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="addProduct()">
                                    Add Item
                                </button>
                            </div>
                        </div>
                    </div>
                    <br/>
                </div>
            </div>
        </div>
    </div>
</div>


<jsp:include page="include/foot.jsp"/>
<script type="text/javascript">
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    function deleteUser(id) {
        var user = {};
        user.id = id;
        var deleteResult = "";
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/deleteUser',
            data: user,
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            dataType: 'json',
            success: function (result) {
                deleteResult = result;
            },
            error: function (result) {
                layer.alert('Search User Error');
            }
        });
        layer.msg(deleteResult.message);
        window.location = "/main";
    }

    function deleteProduct(id) {
        var product = {};
        product.id = id;
        var deleteResult = "";
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/deleteProduct',
            data: product,
            dataType: 'json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function (result) {
                deleteResult = result;
            },
            error: function (result) {
                layer.alert('Delete Item Error');
            }
        });
        layer.msg(deleteResult.message);
        window.location = "/main";
    }

    function addProduct() {
        var loadings = layer.load(0);
        var product = {};
        product.name = document.getElementById("productName").value;
        product.description = document.getElementById("productDescribe").value;
        product.price = document.getElementById("productPrice").value;
        product.counts = document.getElementById("productCount").value;
        var addResult = "";
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/addProduct',
            data: product,
            dataType: 'json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function (result) {
                addResult = result.result;
            },
            error: function (result) {
                layer.alert('Delete Item Error');
            }
        });
        if (addResult == "success") {
            layer.msg('Add Item Success', {icon: 1, time: 1000});
            layer.close(loadings)
        }
        window.location = "/main";
    }
</script>
</body>
</html>
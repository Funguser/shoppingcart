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
    <script src="${cp}/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${cp}/js/layer.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
    <script src="${cp}/js/html5shiv.min.js"></script>
    <script src="${cp}/js/js/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<c:if test="${not empty sessionScope.currentUser}">
    <c:if test="${sessionScope.currentUser.role eq 1}">
        <c:redirect url="/control"></c:redirect>
    </c:if>
</c:if>
<jsp:include page="include/header.jsp"/>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div name="productArea1" class="row pd-10" id="productArea1">
                <c:forEach var="product" items="${sessionScope.allProduct}">
                    <div class="col-sm-4 col-md-4">
                        <div class="boxes pointer" onclick="productDetail(${product.id})">
                            <div class="big bigimg">
                                <img src="${cp}/img/tmp.jpg">
                            </div>
                            <p class="product-name">${product.name}</p>
                            <p class="product-price">${product.price}</p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2">
            <jsp:include page="include/foot.jsp"/>
        </div>
    </div>
</div>

<script type="text/javascript">
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");

    function productDetail(id) {
        var product = {};
        var jumpResult = '';
        product.id = id;
        $.ajax({
            async: false,
            type: 'POST',
            url: '${cp}/productDetail',
            data: product,
            dataType: 'json',
            beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
            },
            success: function (result) {
                jumpResult = result.result;
            },
            error: function (resoult) {
                layer.alert('Search Error');
            }
        });

        if (jumpResult == "success") {
            window.location.href = "${cp}/product_detail";
        }
    }

</script>


</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Shopping Cart</title>
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


<div class="container-fluid" style="padding-top: 80px;padding-bottom: 80px">

    <h1 class="title center">Admin Log in</h1>
    <br/>
    <div class="col-sm-offset-2 col-md-offest-2">

        <div class="form-horizontal">
            <form name="loginForm" action="<c:url value='login'/>" method="POST">
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 col-md-2 control-label">Email/Username</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="inputEmail" name="username"
                               placeholder="xxxxxx@xx.com"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 col-md-2 control-label">Password</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="password" class="form-control" id="inputPassword" name="password"
                               placeholder="password"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-6">
                        <button class="btn btn-lg btn-primary btn-block" type="submit">Login
                        </button>
                    </div>
                </div>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            </form>
        </div>
        <br/>
    </div>
</div>
<jsp:include page="include/foot.jsp"/>
</body>
</html>
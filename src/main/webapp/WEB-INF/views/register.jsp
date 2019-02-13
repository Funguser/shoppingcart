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
      <script src="${cp}/js/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>

    <jsp:include page="include/header.jsp"/>

    <div class="container-fluid">
        <h1 class="title center">Sign up</h1>
        <br/>
        <div class="col-sm-offset-2 col-md-offest-2">

            <div  class="form-horizontal">
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 col-md-2 control-label">Username</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="inputUserName" placeholder="please input" required="required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 col-md-2 control-label">Email</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="email" class="form-control" id="inputEmail" placeholder="xxxx@xxxx.com" required="required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 col-md-2 control-label">Password</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="password" class="form-control" id="inputPassword" placeholder="password" required="required"/>
                    </div>
                </div>

                <div class="form-group">
                    <label for="inputPhoneNumber" class="col-sm-2 col-md-2 control-label">Phone</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="number" class="form-control" id="inputPhoneNumber" placeholder="+1 xxxxxxxxxx" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="address" class="col-sm-2 col-md-2 control-label">Address</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="address" placeholder="asdasdasd" required="required"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-6">
                        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="startRegister()">Sign up</button>
                    </div>
                </div>
            </div>
            <br/>
        </div>
    </div>

    <!--尾部-->
    <jsp:include page="include/foot.jsp"/>
    <script type="text/javascript">
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        function startRegister() {
            var loading = layer.load(0);
            var user = {};
            user.userName = document.getElementById("inputUserName").value;
            user.email = document.getElementById("inputEmail").value;
            user.password = document.getElementById("inputPassword").value;
            user.phoneNumber = document.getElementById("inputPhoneNumber").value;
            user.address = document.getElementById("address").value;

            var registerResult = null;
            $.ajax({
                async : false,
                type : 'POST',
                url : '${cp}/doRegister',
                data : user,
                dataType : 'json',
                beforeSend : function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                success : function(result) {
                    registerResult = result.result;
                },
                error : function(result) {
                    layer.alert('Error');
                }
            });
            if(registerResult == 'success'){
                layer.close(loading);
                layer.msg('Sign Up Success',{icon:1});
                window.location.href="${cp}/login";
            }
            else if(registerResult == 'nameExist'){
                layer.close(loading);
                layer.msg('Username Occupied',{icon:2});
            }
            else if(registerResult == 'emailExist'){
                layer.close(loading);
                layer.msg('Email Occupied',{icon:2});
            }
            else if(registerResult == 'fail'){
                layer.close(loading);
                layer.msg('Error',{icon:2});
            }
        }
    </script>
  </body>
</html>
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


    <div class="container-fluid" style="padding-top: 80px;padding-bottom: 80px" >

        <h1 class="title center">Log in</h1>
        <br/>
        <div class="col-sm-offset-2 col-md-offest-2">

            <div  class="form-horizontal">
                <div class="form-group">
                    <label for="inputEmail" class="col-sm-2 col-md-2 control-label">Email/Username</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="text" class="form-control" id="inputEmail" name="username" placeholder="xxxxxx@xx.com" required="required"/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="inputPassword" class="col-sm-2 col-md-2 control-label">Password</label>
                    <div class="col-sm-6 col-md-6">
                        <input type="password" class="form-control" id="inputPassword" name="password" placeholder="password"  required="required"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-6">
                        <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="startLogin()">Login</button>
                    </div>
                </div>
            </div>
            <br/>
        </div>
    </div>


    <jsp:include page="include/foot.jsp"/>

    <script type="text/javascript">
        var token = $("meta[name='_csrf']").attr("content");
        var header = $("meta[name='_csrf_header']").attr("content");
        function startLogin() {
            var loading = layer.load(0);
            var user = {};
            var loginResult = "";
            user.userNameOrEmail = document.getElementById("inputEmail").value;
            user.password = document.getElementById("inputPassword").value;
            $.ajax({
                async : false,
                type : 'POST',
                url : '${cp}/doLogin',
                data : user,
                beforeSend : function(xhr) {
                    xhr.setRequestHeader(header, token);
                },
                dataType : 'json',
                success : function(result) {
                    loginResult = result.result;
                    layer.close(loading);
                },
                error : function(result) {
                    layer.alert('Search User Error');
                }
            });

            if(loginResult == 'success'){
                layer.msg('Login Success',{icon:1});
                if(user.role == 1)
                    window.location.href = "${cp/control}"
                window.location.href = "${cp}/main";
            }
            else if(loginResult == 'unexist'){
                layer.msg('Forgot Username?',{icon:2});
            }
            else if(loginResult == 'wrong'){
                layer.msg('Password Error',{icon:2});
            }
            else if(loginResult == 'fail'){
                layer.msg('Server Error',{icon:2});
            }
        }
    </script>

  </body>
</html>
package com.shopping.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.shopping.dao.ProductDao;
import com.shopping.entity.User;
import com.shopping.entity.UserDetail;
import com.shopping.service.ProductService;
import com.shopping.service.UserDetailService;
import com.shopping.service.UserService;
import com.shopping.utils.Response;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Pattern;

@Controller
public class UserController {

    @Resource
    UserService userService;

    @Resource
    ProductService productService;

    @Resource
    UserDetailService userDetailService;


    @RequestMapping(value = "/register")
    public String register() {
        return "register";
    }

    @RequestMapping(value = "/login")
    public String login() {
        return "login";
    }

    @RequestMapping(value = "/admin_login")
    public String adminLogin() {
        return "admin_login";
    }

    @RequestMapping(value = "/main")
    public String main(HttpSession session) {
        session.setAttribute("allUser", userService.getAllUser());
        session.setAttribute("allProduct", productService.getAllProduct());
        return "main";
    }

    @RequestMapping(value = "/control")
    public String control(HttpSession session) {
        User user = new User();
        user.setName("admin");
        user.setRole(1);
        UserDetail userDetail = new UserDetail();
        session.setAttribute("currentUser", user);
        session.setAttribute("currentUserDetail", userDetail);
        session.setAttribute("allUser", userService.getAllUser());
        session.setAttribute("allProduct", productService.getAllProduct());
        return "control";
    }

    @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> doLogin(String userNameOrEmail, String password, HttpSession httpSession) {
        String result = "fail";
        User user = userService.getUser(userNameOrEmail);
        if (user == null)
            result = "unexist";
        else {
            UserDetail userDetail = userDetailService.getUserDetail(user.getId());
            if (userDetail.getPassword().equals(password) && user.getRole() == 0) {
                result = "success";
                httpSession.setAttribute("currentUser", user);
                httpSession.setAttribute("currentUserDetail", userDetail);
            } else
                result = "wrong";
        }
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result", result);
        return resultMap;
    }

    @RequestMapping(value = "/doRegister", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> doRegister(String userName, String email, String password, String phoneNumber, String address) {
        String result = "fail";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        if (isValid(userName) && isValid(email) && isValid(password) && isValid(phoneNumber) && isValid(address)) {
            User user = userService.getUser(userName);
            if (user != null) {
                result = "nameExist";
            } else {
                user = userService.getUser(email);
                if (user != null)
                    result = "emailExist";
                else {
                    User user1 = new User();
                    user1.setName(userName);
                    user1.setEmail(email);
                    user1.setRole(0);
                    userService.addUser(user1);

                    UserDetail userDetail = new UserDetail();
                    userDetail.setId(user1.getId());
                    userDetail.setAddress(address);
                    userDetail.setPassword(password);
                    userDetail.setPhoneNumber(phoneNumber);

                    userDetailService.addUserDetail(userDetail);
                    result = "success";
                }
            }
        }
        resultMap.put("result", result);
        return resultMap;
    }

    @RequestMapping(value = "/getAllUser", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAllUser() {
        List<User> userList;
        userList = userService.getAllUser();
        String allUsers = JSONArray.toJSONString(userList);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("allUsers", allUsers);
        return resultMap;
    }

    @RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
    @ResponseBody
    public Response deleteUser(int id, HttpSession session) {
        Response response = userService.deleteUser(id);
        session.setAttribute("allUser", userService.getAllUser());
        return response;
    }

    @RequestMapping(value = "/getUserAddressAndPhoneNumber", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUserAddressAndPhoneNumber(int id) {
        String address = userDetailService.getUserDetail(id).getAddress();
        String phoneNumber = userDetailService.getUserDetail(id).getPhoneNumber();
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("address", address);
        resultMap.put("phoneNumber", phoneNumber);
        return resultMap;
    }

    @RequestMapping(value = "/doLogout")
    public String doLogout(HttpSession httpSession, HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:login";
    }

    @RequestMapping(value = "/getUserById", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUserById(int id) {
        User user = userService.getUser(id);
        String result = JSON.toJSONString(user);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result", result);
        return resultMap;
    }

    @RequestMapping(value = "/getUserDetailById", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUserDetailById(int id) {
        UserDetail userDetail = userDetailService.getUserDetail(id);
        String result = JSON.toJSONString(userDetail);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result", result);
        return resultMap;
    }


    private static String reg = "(?:')|(?:--)|(/\\*(?:.|[\\n\\r])*?\\*/)|"
            + "(\\b(select|update|union|and|or|delete|insert|trancate|char|into|substr|ascii|declare|exec|count|master|into|drop|execute)\\b)";

    private static Pattern sqlPattern = Pattern.compile(reg, Pattern.CASE_INSENSITIVE);

    private boolean isValid(String str) {
        if (sqlPattern.matcher(str).find()) {
            return false;
        }
        if (str.length() > 15)
            return false;
        return true;
    }

}

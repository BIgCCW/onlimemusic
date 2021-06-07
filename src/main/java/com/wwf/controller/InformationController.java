package com.wwf.controller;

import com.wwf.pojo.User;
import com.wwf.service.UserService;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author wwf
 * @date 2021/5/28
 */
@Controller
public class InformationController {
    @Autowired
    @Qualifier("UserServiceImpl")
    private UserService userService;

    @RequestMapping("/info")
    public String info(User user, HttpSession session){
        String username = (String) session.getAttribute("username");
        userService.updateInformation(user.getEmail(),user.getSex(),user.getBirthday(), username);
        return "redirect:/user";
    }

    @RequestMapping("/newUser")
    public String newUser(String newUser, HttpSession session, HttpServletResponse response, HttpServletRequest req) throws IOException {
        String username = (String) session.getAttribute("username");
        userService.updateUserName(newUser,username);
        session.removeAttribute("username");
        session.removeAttribute("song");
        String path=req.getServletContext().getContextPath();
        PrintWriter out = response.getWriter();
        out.print( "<script>window.parent.location.href=\""+path+"/login\";</script>");
        out.flush();
        return null;
    }

    @RequestMapping("/newPwd")
    public String newPwd(String Pwd,HttpSession session, HttpServletResponse response, HttpServletRequest req) throws IOException {
        String username = (String) session.getAttribute("username");
        userService.updateUserPwd(Pwd, username);
        session.removeAttribute("username");
        session.removeAttribute("song");
        String path=req.getServletContext().getContextPath();
        PrintWriter out = response.getWriter();
        out.print( "<script>window.parent.location.href=\""+path+"/login\";</script>");
        out.flush();
        return null;
    }
}

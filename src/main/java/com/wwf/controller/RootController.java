package com.wwf.controller;

import com.wwf.pojo.Apply;
import com.wwf.pojo.Message;
import com.wwf.service.ApplyService;
import com.wwf.service.MessageService;
import com.wwf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author wwf
 * @date 2021/5/30
 */
@Controller
@RequestMapping("/root")
public class RootController {
    @Autowired
    @Qualifier("ApplyServiceImpl")
    private ApplyService applyService;

    @Autowired
    @Qualifier("UserServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("MessageServiceImpl")
    private MessageService messageService;

    //申请管理
    @RequestMapping("/applyAdmi")
    public String applyAdmi(Model model){
        List<Apply> applies = applyService.selectAll();
        model.addAttribute("applies", applies);
        return "root/applyAdmi";
    }

    //同意提权申请
    @RequestMapping("/agreeApply")
    @ResponseBody
    public void agreeApply(String name,String operation,String jur){
        refuseApply(name,operation);
        userService.updateJur(name,jur);
    }
    //拒绝申请
    @RequestMapping("/refuse")
    @ResponseBody
    public void refuseApply(String name,String operation){
        applyService.deleteApply(name, operation);
    }

    //同意注销申请
    @RequestMapping("/agreeAccount")
    @ResponseBody
    public void agreeAccount(String name){
        applyService.deleteAll(name);
        userService.deleteUser(name);
    }

    //留言管理页面
    @RequestMapping("/messageAdmin")
    public String messageAdmin(Model model){
        List<Message> messages = messageService.selectAll();
        model.addAttribute("messages", messages);
        return "root/messageAdmin";
    }

    //删除留言
    @RequestMapping("/deleteMessage")
    @ResponseBody
    public void deleteMessage(String sid){
        messageService.deleteMessage(sid);
    }

    //用户管理
    @RequestMapping("/userAdmin")
    public String userAdmin(Model model){
        model.addAttribute("userAdmin",userService.selectAllUser());
        return "root/userAdmin";
    }

    //重置用户密码
    @RequestMapping("/updatePwd")
    @ResponseBody
    public void updatePwd(String name){
        userService.updateUserPwd("123456w", name);
    }

    //管理权限
    @RequestMapping("/jurAdmin")
    public String jurAdmin(String name,String jur,Model model){
            userService.updateJur(name,jur);
            model.addAttribute("userAdmin",userService.selectAllUser());
            return "root/userAdmin";
    }


}

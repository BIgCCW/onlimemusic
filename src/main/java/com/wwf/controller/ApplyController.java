package com.wwf.controller;

import com.wwf.pojo.Apply;
import com.wwf.pojo.User;
import com.wwf.service.ApplyService;
import com.wwf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * @author wwf
 * @date 2021/5/30
 */
@Controller
public class ApplyController {
    @Autowired
    @Qualifier("ApplyServiceImpl")
    private ApplyService applyService;


    @Autowired
    @Qualifier("UserServiceImpl")
    private UserService userService;

    //提交权限申请
    @RequestMapping("/apply")
    public String apply(Apply apply, HttpSession session){
      apply.setUsername((String) session.getAttribute("username"));
      apply.setOperation("提权");
      applyService.addApply(apply);
      return "other/applySuccess";
    }

    //注销账号申请
    @RequestMapping("/applyAccount")
    public String account(Apply apply,HttpSession session){
        apply.setUsername((String) session.getAttribute("username"));
        apply.setOperation("注销");
        User user = userService.selectUser(apply.getUsername());
        String jurisdiction ="原权限-"+user.getJurisdiction();
        apply.setJurisdiction(jurisdiction);
        applyService.addApply(apply);
        return "other/applySuccess";
    }

}

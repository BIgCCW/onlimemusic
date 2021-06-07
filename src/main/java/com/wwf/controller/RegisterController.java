package com.wwf.controller;

import com.alibaba.fastjson.JSON;
import com.wwf.pojo.Music;
import com.wwf.pojo.User;
import com.wwf.service.MusicService;
import com.wwf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author wwf
 * @date 2021/5/14
 */
@Controller
public class RegisterController {
    @Autowired
    @Qualifier("UserServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("MusicServiceImpl")
    private MusicService musicService;

    //注册
    @RequestMapping("/register")
    public String register(User user) {
        userService.addUser(user);
        return "redirect:/login";
    }

    //判断用户名和密码
    @RequestMapping("/selectUser")
    @ResponseBody
    public String selectUser(String username, String password) {
        String result = "";
        User user = userService.selectUser(username);
        if (user == null) {
            result = "null";
        } else if (password != null) {
            result = user.getPassword();
            if (password.equals(result)) {
                result = "pwdTrue";
            }
        }
        return result;
    }

    //登录
    @RequestMapping("/userLogin")
    public String userLogin(String userName, HttpSession session) {
        session.setAttribute("username", userName);
        User user = userService.selectMusicId(userName);
        String musicId = user.getMusicId();
        if (musicId !=null){
            String[] split = musicId.split(",");
            List<Music> music = new ArrayList<>();
            for (String s : split) {
                int i = Integer.parseInt(s);
                Music music1 = musicService.queryById(i);
                music.add(music1);
            }
            session.setAttribute("song", music);
        }
        return "redirect:/index.jsp";
    }

    //注销
    @RequestMapping("/cancellation")
    public String cancellation(HttpSession session) {
        session.removeAttribute("username");
        session.removeAttribute("song");
        return "redirect:/index.jsp";
    }


//    //查询曲库歌曲id
//    @RequestMapping("/selectMusicId")
//    @ResponseBody
//    public String selectMusicId(HttpSession session){
//        String username= (String) session.getAttribute("username");
//        User user = userService.selectUser(username);
//        String musicId= user.getMusicId();
//        String[] allMusicId;
//        if (musicId.equals("")){
//            allMusicId=null;
//        }else {
//           allMusicId=musicId.split(",");
//        }
//        return JSON.toJSONString(allMusicId);
//    }

    //添加用户曲库id
    @RequestMapping("/updateMusicId")
    @ResponseBody
    public void updateMusicId(String sid, HttpSession session) {
        String username = (String) session.getAttribute("username");
        User user = userService.selectMusicId(username);
        String musicId;
        if (user.getMusicId()==null) {
            musicId = sid;
        } else {
            musicId = user.getMusicId() + "," + sid;
        }
        userService.updateMusicId(musicId, username);
    }
}

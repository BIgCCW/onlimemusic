package com.wwf.controller;

import com.wwf.pojo.Apply;
import com.wwf.pojo.Music;
import com.wwf.pojo.User;
import com.wwf.service.ApplyService;
import com.wwf.service.MessageService;
import com.wwf.service.MusicService;
import com.wwf.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * @author wwf
 * @date 2021/5/18
 */
@Controller
public class BackstageController {
    @Autowired
    @Qualifier("ApplyServiceImpl")
    private ApplyService applyService;

    @Autowired
    @Qualifier("UserServiceImpl")
    private UserService userService;

    @Autowired
    @Qualifier("MusicServiceImpl")
    private MusicService musicService;

    @Autowired
    @Qualifier("MessageServiceImpl")
    private MessageService messageService;

    private String oneName = "-";

    //后台页面的各个访问地址
    @RequestMapping("/backstage")
    public String backstage() {
        return "backstage/backstage";
    }

    @RequestMapping("/home")
    public String home() {
        return "backstage/home";
    }

    //权限不足
    @RequestMapping("/notRoot")
    public String notRoot(){
        return "other/notRoot";
    }

    @RequestMapping("/account")
    public String account(HttpSession session) {
        String username = (String) session.getAttribute("username");
        Apply apply = applyService.selectUser(username,"注销");
        if (apply!=null){
                return "other/applySuccess";
        }
        return "backstage/account";
    }

    @RequestMapping("/admin/addHouse")
    public String addHouse() {
        return "backstage/addHouse";
    }

    @RequestMapping("/jurisdiction")
    public String jurisdiction(HttpSession session) {
        String username = (String) session.getAttribute("username");
        Apply apply = applyService.selectUser(username,"提权");
        if (apply!=null){
                return "other/applySuccess";
        }
        return "backstage/jurisdiction";
    }

    //用户信息
    @RequestMapping("/user")
    public String user(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        User user = userService.selectUser(username);
        model.addAttribute("user", user);
        int counts = messageService.selectUserAll(username);
        model.addAttribute("count", counts);
        String musicId = user.getMusicId();
        String[] allMusicId;
        if (musicId == null) {
            model.addAttribute("countMusic", 0);
        } else {
            allMusicId = musicId.split(",");
            int count = 0;
            for (String s : allMusicId) {
                int i = Integer.parseInt(s);
                count++;
            }
            model.addAttribute("countMusic", count);
        }
        return "backstage/user";
    }


    //查询曲库歌曲呈现在歌单管理上
    @RequestMapping("/userSong")
    public String userSong(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        User user = userService.selectUser(username);
        String musicId = user.getMusicId();
        String[] allMusicId;
        if (musicId == null) {
            model.addAttribute("userSong", null);
            model.addAttribute("count", 0);
        } else {
            allMusicId = musicId.split(",");
            List<Music> userSong = new ArrayList<>();
            int count = 0;
            for (String s : allMusicId) {
                int i = Integer.parseInt(s);
                Music music = musicService.queryById(i);
                userSong.add(music);
                count++;
            }
            model.addAttribute("userSong", userSong);
            model.addAttribute("count", count);
        }
        return "backstage/song";
    }

    //查找功能
    @RequestMapping("/userLookup")
    public String userLookup(Model model, String name, HttpSession session) {
        Object username = session.getAttribute("username");
        User user = userService.selectUser(username.toString());
        String musicId = user.getMusicId();
        String[] allMusicId = musicId.split(",");
        if (name != null) {
            oneName = name;
        }
        List<Music> music = musicService.queryMusic(oneName);
        List<Music> userSong = new ArrayList<>();
        int count = 0;
        for (Music music1 : music) {
            int id = music1.getId();
            for (String s : allMusicId) {
                int i = Integer.parseInt(s);
                if (i == id) {
                    count++;
                    userSong.add(music1);
                }
            }
        }
        model.addAttribute("userSong", userSong);
        model.addAttribute("count", count);
        return "backstage/song";

    }

    //删除功能
    @RequestMapping("/userDelete")
    @ResponseBody
    public void userDelete(String sid, HttpSession session) {
        String name = (String) session.getAttribute("username");
        User user = userService.selectUser(name);
        String musicId = user.getMusicId();
        String newMusicId;
        if (musicId.indexOf(sid) == musicId.length() - sid.length()) {
            newMusicId = musicId.replaceFirst(sid, "");
        } else {
            newMusicId = musicId.replaceFirst(sid + ",", "");
        }
        List<Music> song = (List<Music>) session.getAttribute("song");
        int i = Integer.parseInt(sid);
        //迭代器安全不报错
        Iterator<Music> iterator = song.iterator();
        while (iterator.hasNext()) {
            Music next = iterator.next();
            if (next.getId() == i) {
                iterator.remove();
            }
        }
        userService.deleteMusic(newMusicId, name);
        session.setAttribute("song", song);
    }

    //查询用户权限
    @RequestMapping("/getJur")
    @ResponseBody
    public String getJur(HttpSession session){
        String username = (String) session.getAttribute("username");
        String jurisdiction = userService.selectUser(username).getJurisdiction();
        return jurisdiction;
    }

    //判断密码
    @RequestMapping("/addApplyPwd")
    @ResponseBody
    public String selectUser(HttpSession session, String password) {
        String username = (String) session.getAttribute("username");
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
}

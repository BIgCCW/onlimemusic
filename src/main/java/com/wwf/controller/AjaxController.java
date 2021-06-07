package com.wwf.controller;

import com.alibaba.fastjson.JSON;
import com.wwf.pojo.Music;
import com.wwf.service.MusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author wwf
 * @date 2021/4/29
 */
@RestController
public class AjaxController {
    @Autowired
    @Qualifier("MusicServiceImpl")
    private MusicService musicService;


    //ajax获取session song值
    @RequestMapping("/getSession")
    public String getSession(HttpSession session){
        List<Music> addSong = (List<Music>) session.getAttribute("song");
        if (addSong != null){
            List<Integer> ids = new ArrayList<>();
            for (Music music : addSong) {
                int id = music.getId();
                ids.add(id);
            }
            return  JSON.toJSONString(ids);
        }
        return "0";
    }

    //添加歌曲
    @RequestMapping("/add")
    public void add(HttpSession session,String sid) {
//        System.out.println(sid);
        int id = Integer.parseInt(sid);
        Music addMusic = musicService.queryById(id);
        if (session.getAttribute("song") != null && addMusic != null) {
            int flag = 0;
            List<Music> addSong = (List<Music>) session.getAttribute("song");
            for (Music m : addSong) {
                int id1 = m.getId();
                if (id1 == id) {
                    flag++;
                }
            }
            if (flag==0){
                addSong.add(addMusic);
                session.setAttribute("song", addSong);
            }
        } else if(addMusic != null){
            List<Music> aMusic = new ArrayList<>();
            aMusic.add(addMusic);
            session.setAttribute("song", aMusic);
        }
//        System.out.println(addMusic);
    }

    @RequestMapping("/deleteSession")
    public void delete(HttpSession session, String name){
        List<Music> addSong = (List<Music>) session.getAttribute("song");
        for (Music music : addSong) {
            String title1 = music.getTitle();
            if (title1.equals(name)){
                addSong.remove(music);
            }
        }
        session.setAttribute("song", addSong);
    }


    //ajax获取session 验证码值
    @RequestMapping("/getCodeSession")
    public String getCodeSession(HttpSession session){
        return  JSON.toJSONString(session.getAttribute("verifyCode"));
    }

}

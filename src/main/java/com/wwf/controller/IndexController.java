package com.wwf.controller;

import com.github.pagehelper.PageInfo;
import com.wwf.pojo.Message;
import com.wwf.pojo.Music;
import com.wwf.service.MessageService;
import com.wwf.service.MusicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.net.URLEncoder;
import java.util.*;

/**
 * @author wwf
 * @date 2021/4/24
 */
@Controller
public class IndexController {
    @Autowired
    @Qualifier("MusicServiceImpl")
    private MusicService musicService;

    @Autowired
    @Qualifier("MessageServiceImpl")
    private MessageService messageService;

    private  String oneName="-";

    //获取所有的歌曲
    @RequestMapping("/house")
    public String house(Model model, @RequestParam(name="page",required = true,defaultValue = "1")int page, @RequestParam(name="size",required = true,defaultValue = "10")int size ) {
        List<Music> ordersList = musicService.queryAllMusic(page,size);
        //PageInfo就是一个分页Bean
        PageInfo pageInfo =new PageInfo(ordersList);
        model.addAttribute("pageInfos", pageInfo);
        return "musichouse/house";
    }

    @RequestMapping("/lookup")
    public String lookup(Model model, @RequestParam(name="page",required = true,defaultValue = "1")int page, @RequestParam(name="size",required = true,defaultValue = "10")int size,String name ) {
        if (name != null){
             oneName=name;
        }
        List<Music> ordersList = musicService.queryMusic(oneName,page,size);
        //PageInfo就是一个分页Bean
        PageInfo pageInfo =new PageInfo(ordersList);
        model.addAttribute("pageInfos", pageInfo);
        return "musichouse/house";
    }
    //播放单独的歌曲
    @RequestMapping("/play/{id}")
    public synchronized String play(HttpSession session, @PathVariable int id) {
        Music addMusic = musicService.queryById(id);
        if (session.getAttribute("song") != null && addMusic != null) {
            List<Music> addSong = (List<Music>) session.getAttribute("song");
            int flag=0;
            Iterator<Music> iterator = addSong.iterator();
            while (iterator.hasNext()){
                Music next = iterator.next();
                int id1 = next.getId();
                if (id1 == id) {
                    flag++;
                    int i = addSong.indexOf(next);
                    Collections.swap(addSong,i,0);//将歌曲调到最前面
                }
            }
            session.setAttribute("song", addSong);
            if (flag==0){
                addSong.add(0, addMusic);
                session.setAttribute("song", addSong);
            }

        } else if (addMusic != null) {
            List<Music> music = new ArrayList<>();
            music.add(addMusic);
            session.setAttribute("song", music);
        }
//        System.out.println(session.getAttribute("song"));
        return "play/play";
    }

    //下载
    @RequestMapping("/download/{title}")
    public String downloads(HttpServletResponse response , HttpServletRequest request,@PathVariable String title){
        //要下载的地址
        String  path = request.getServletContext().getRealPath("/music");
        //文件名
        String  fileName =title+".mp3";

        OutputStream out = null;
        InputStream input = null;
        try {
            //1、设置response 响应头
            response.reset(); //设置页面不缓存,清空buffer
            response.setCharacterEncoding("UTF-8"); //字符编码
            response.setContentType("multipart/form-data"); //二进制传输数据
            //设置响应头(让浏览器下载)
            response.setHeader("Content-Disposition",
                    "attachment;fileName="+ URLEncoder.encode(fileName, "UTF-8"));


            File file = new File(path,fileName);
            //2、 读取文件--输入流
             input=new FileInputStream(file);
            //3、 写出文件--输出流
             out = response.getOutputStream();

            byte[] buff =new byte[1024];
            int index=0;
            //4、执行 写出操作
            while((index= input.read(buff))!= -1){
                out.write(buff, 0, index);
                out.flush();
            }

        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (out != null){
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (input != null){
                try {
                    input.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }

    //登录页面
    @RequestMapping("/login")
    public String login(Model model) {
        return "redirect:page/login/login.jsp";
    }

    //听歌页面
    @RequestMapping("/listen")
    public String listen(HttpSession session) {
            return "/play/play";
    }
    //留言页面
    @RequestMapping("/message")
    public String message(Model model) {
        List<Message> messages = messageService.selectAll();
        model.addAttribute("messages",messages);
        return "message/message";
    }

    //添加留言
    @RequestMapping("/addMessage")
    @ResponseBody
    public void addMessage(String message,HttpSession session){
        Message message1 = new Message();
        if(session.getAttribute("username")==null){
            message1.setName("游客");
        }else{
            message1.setName((String) session.getAttribute("username"));
        }
        message1.setText(message);
        messageService.addMessage(message1);
    }
}

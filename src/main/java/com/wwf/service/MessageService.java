package com.wwf.service;

import com.wwf.pojo.Message;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wwf
 * @date 2021/6/1
 */
public interface MessageService {

    //查询所有记录
    List<Message> selectAll();

    //添加留言
    int addMessage(Message message);

    //删除留言
    int deleteMessage( String id);

    //查询用户留言条数
    int selectUserAll( String name);
}

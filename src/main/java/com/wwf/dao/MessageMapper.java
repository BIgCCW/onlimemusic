package com.wwf.dao;

import com.wwf.pojo.Message;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author wwf
 * @date 2021/6/1
 */
@Repository
public interface MessageMapper {
    //查询所有记录
    List<Message> selectAll();

    //添加留言
    int addMessage(Message message);

    //删除留言
    int deleteMessage(@Param("id") String id);

    //查询用户留言条数
    int selectUserAll(@Param("name") String name);

}

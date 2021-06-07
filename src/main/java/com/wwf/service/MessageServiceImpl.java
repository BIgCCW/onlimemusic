package com.wwf.service;

import com.wwf.dao.MessageMapper;
import com.wwf.pojo.Message;

import java.util.List;

/**
 * @author wwf
 * @date 2021/6/1
 */
public class MessageServiceImpl implements MessageService{

    private MessageMapper messageMapper;

    public void setMessageMapper(MessageMapper messageMapper) {
        this.messageMapper = messageMapper;
    }

    @Override
    public List<Message> selectAll() {
        return messageMapper.selectAll();
    }

    @Override
    public int addMessage(Message message) {
        return messageMapper.addMessage(message);
    }

    @Override
    public int deleteMessage(String id) {
        return messageMapper.deleteMessage(id);
    }

    @Override
    public int selectUserAll(String name) {
        return messageMapper.selectUserAll(name);
    }
}

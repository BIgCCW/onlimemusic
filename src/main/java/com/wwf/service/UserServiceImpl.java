package com.wwf.service;

import com.wwf.dao.UserMapper;
import com.wwf.pojo.User;

import java.util.List;

/**
 * @author wwf
 * @date 2021/5/14
 */
public class UserServiceImpl implements UserService{
    private UserMapper userMapper;

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public int addUser(User user) {
        return userMapper.addUser(user);
    }

    @Override
    public User selectUser(String name) {
        return userMapper.selectUser(name);
    }

    @Override
    public int updateMusicId(String musicId, String name) {
        return userMapper.updateMusicId(musicId, name);
    }

    @Override
    public User selectMusicId(String username) {
        return userMapper.selectMusicId(username);
    }

    @Override
    public int deleteMusic(String musicId, String name) {
        return updateMusicId(musicId,name);
    }

    @Override
    public int updateInformation(String email, String sex, String birthday, String username) {
        return userMapper.updateInformation(email,sex,birthday,username);
    }

    @Override
    public int updateUserName(String newName, String username) {
        return userMapper.updateUserName(newName,username);
    }

    @Override
    public int updateUserPwd(String Pwd, String username) {
        return userMapper.updateUserPwd(Pwd,username);
    }

    @Override
    public int updateJur(String name, String jur) {
        return userMapper.updateJur(name, jur);
    }

    @Override
    public int deleteUser(String name) {
        return userMapper.deleteUser(name);
    }

    @Override
    public List<User> selectAllUser() {
        return userMapper.selectAllUser();
    }


}

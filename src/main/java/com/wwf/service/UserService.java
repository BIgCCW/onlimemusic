package com.wwf.service;

import com.wwf.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author wwf
 * @date 2021/5/14
 */
public interface UserService {

    //注册
    int addUser(User user);

    //查询用户
    User selectUser(String name);

    //添加歌曲id
    int updateMusicId( String musicId, String name);

    //查询用户的曲库id
    User selectMusicId(String username);

    //删除用户歌单歌曲
    int deleteMusic(String musicId, String name);

    //修改基本信息
    int updateInformation(String email,String sex,String birthday,String username);

    //修改用户名
    int updateUserName(String newName,String username);

    //修改密码
    int updateUserPwd(String Pwd,String username);

    //修改权限
    int updateJur(String name,String jur);

    //注销用户
    int deleteUser(String name);

    //查询所有用户
    List<User> selectAllUser();
}

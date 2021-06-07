package com.wwf.dao;

import com.wwf.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author wwf
 * @date 2021/5/14
 */
@Repository
public interface UserMapper {

    //注册
    int addUser(User user);

    //查询用户
    User selectUser(@Param("name") String name);

    //添加歌曲id
    int updateMusicId(@Param("musicId") String musicId,@Param("name") String name);

    //查询用户的曲库id
    User selectMusicId(@Param("username")String username);

    //修改基本信息
    int updateInformation(@Param("email")String email,@Param("sex")String sex,@Param("birthday")String birthday,@Param("name")String username);

    //修改用户名
    int updateUserName(@Param("newName")String newName,@Param("name")String username);

    //修改密码
    int updateUserPwd(@Param("Pwd")String Pwd,@Param("name")String username);

    //修改权限
    int updateJur(@Param("name")String name,@Param("jur")String jur);

    //注销用户
    int deleteUser(@Param("name")String name);

    //查询所有用户
    List<User> selectAllUser();
}

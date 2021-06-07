package com.wwf.dao;

import com.wwf.pojo.Apply;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


/**
 * @author wwf
 * @date 2021/5/30
 */
@Repository
public interface ApplyMapper {

    //添加申请
    int addApply(Apply apply);

    //查询用户是否申请
    Apply selectUser(@Param("name") String username,@Param("operation")String operation);

    //取出所有请求
    List<Apply> selectAll();

    //删除用户请求
    int deleteApply(@Param("name") String name,@Param("operation")String operation);

    //删除用户所有请求
    int deleteAll(@Param("name") String name);
}

package com.wwf.service;

import com.wwf.pojo.Apply;
import org.apache.ibatis.annotations.Param;

import java.util.List;


/**
 * @author wwf
 * @date 2021/5/30
 */

public interface ApplyService {
    //添加申请
    int addApply(Apply apply);

    //查询用户是否申请
    Apply selectUser( String username,String operation);

    //取出所有请求
    List<Apply> selectAll();

    //删除用户请求
    int deleteApply(String name,String operation);


    //删除用户所有请求
    int deleteAll( String name);
}

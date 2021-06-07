package com.wwf.service;

import com.wwf.dao.ApplyMapper;
import com.wwf.pojo.Apply;

import java.util.List;

/**
 * @author wwf
 * @date 2021/5/30
 */
public class ApplyServiceImpl implements ApplyService{
    private ApplyMapper applyMapper;

    public void setApplyMapper(ApplyMapper applyMapper) {
        this.applyMapper = applyMapper;
    }

    @Override
    public int addApply(Apply apply) {
        return   applyMapper.addApply(apply);
    }

    @Override
    public Apply selectUser(String username, String operation) {
        return applyMapper.selectUser(username,operation);
    }

    @Override
    public List<Apply> selectAll() {
        return applyMapper.selectAll();
    }

    @Override
    public int deleteApply(String name, String operation) {
        return applyMapper.deleteApply(name, operation);
    }

    @Override
    public int deleteAll(String name) {
        return applyMapper.deleteAll(name);
    }

}

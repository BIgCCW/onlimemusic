package com.wwf.service;

import com.wwf.pojo.Music;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author wwf
 * @date 2021/4/24
 */
public interface MusicService {
    //查询所有歌曲
    List<Music> queryAllMusic(int page,int size);

    //根据id查询
    Music queryById(@Param("id") int id);
    //条数
    int queryCount();

    List<Music> queryMusic(String name,int page,int size);

    List<Music> queryMusic(String name);

    //曲库添加
    int insertMusic(Music music);
}

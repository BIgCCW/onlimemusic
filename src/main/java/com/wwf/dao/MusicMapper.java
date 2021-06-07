package com.wwf.dao;

import com.wwf.pojo.Music;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @author wwf
 * @date 2021/4/24
 */
@Repository
public interface MusicMapper {
    //查找所有歌曲
    List<Music> queryAllMusic();

    //查找单个歌曲
    Music queryById(@Param("id") int id);

    int queryCount();
    //查找歌曲功能
    List<Music> queryMusic(@Param("name") String name);

    //曲库添加
    int insertMusic(Music music);
}

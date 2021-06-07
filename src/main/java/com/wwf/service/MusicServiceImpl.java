package com.wwf.service;

import com.github.pagehelper.PageHelper;
import com.wwf.dao.MusicMapper;
import com.wwf.pojo.Music;

import java.util.List;
import java.util.Map;

/**
 * @author wwf
 * @date 2021/4/24
 */
public class MusicServiceImpl  implements MusicService{
    private MusicMapper musicMapper;

    public void setMusicMapper(MusicMapper musicMapper) {
        this.musicMapper = musicMapper;
    }

    @Override
    public List<Music> queryAllMusic(int page,int size) {
        PageHelper.startPage(page, size);
        return musicMapper.queryAllMusic();
    }


    @Override
    public Music queryById(int id) {
        Music music = musicMapper.queryById(id);
        return music;
    }

    @Override
    public int queryCount() {
      return   musicMapper.queryCount();
    }

    @Override
    public List<Music> queryMusic(String name,int page,int size) {
        PageHelper.startPage(page, size);
        return queryMusic(name);
    }

    @Override
    public List<Music> queryMusic(String name) {
        return musicMapper.queryMusic(name);
    }

    @Override
    public int insertMusic(Music music) {
        return musicMapper.insertMusic(music);
    }


}

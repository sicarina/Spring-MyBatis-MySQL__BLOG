package com.example.blog.repository;

import java.util.List;

import com.example.blog.model.Board;

public interface BoardRepository {
	List<Board> selectAll(int limit);
	int selectCount();
	int insert(Board board);
	Board select(int id);
	int updateDelDt(int id);
	int update(Board board);
}

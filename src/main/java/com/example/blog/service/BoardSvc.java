package com.example.blog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.blog.model.Board;
import com.example.blog.repository.BoardRepository;

@Service
public class BoardSvc {

	@Autowired
	private BoardRepository boardRep;
	
	public List<Board> selectAll(int limit) {
		return boardRep.selectAll(limit);
	}
	
	public int selectCount() {
		return boardRep.selectCount();
	}
	
	public int insert(Board board) {
		return boardRep.insert(board);
	}
	
	public Board select(int id) {
		return boardRep.select(id);
	}
	
	public int delete(int id) {
		return boardRep.updateDelDt(id);
	}
	
	public int update(Board board) {
		return boardRep.update(board);
	}
}

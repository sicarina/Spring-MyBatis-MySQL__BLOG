package com.example.blog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.blog.model.Board;
import com.example.blog.model.User;
import com.example.blog.service.BoardSvc;
import com.example.blog.utils.Script;

@Controller
@RequestMapping("/board")
public class BoardCtr {
	
	@Autowired
	private BoardSvc boardSvc;
	
	@GetMapping("")
	public String boardPathRedirect() {
		return "redirect:/board/list/1";
	}
	
	@GetMapping("/list/{page}")
	public String selectAll(Model model, @PathVariable int page) {
		int boardCnt = boardSvc.selectCount();
		int maxPage = boardCnt / 5;
		
		if(boardCnt % 5 != 0) {
			maxPage++;
		}
		
		if(maxPage <= 0) {
			maxPage = 1;
		}
		
		if(page <= 0) {
			page = 1;
		} else if (page > maxPage) {
			page = maxPage;
		}
		
		List<Board> boards = boardSvc.selectAll((page-1)*5);
		model.addAttribute("boards", boards);
		
		model.addAttribute("page", page);
		model.addAttribute("maxPage", maxPage);
		
		return "/board/list";
	}
	
	@GetMapping("/writeForm")
	public String writeForm() {
		return "/board/write";
	}
	
	@PostMapping("/write")
	public @ResponseBody String write(HttpServletRequest request, Board board) {
		HttpSession session = request.getSession(); 
		User user = (User)session.getAttribute("user");
		board.setId(user.getId());
		int result = boardSvc.insert(board);
		
		if(result > 0) {
			return Script.location("/board/list/1");
		} else {
			return Script.back("글쓰기에 실패하였습니다. 다시 시도해 주세요.");
		}
	}
	
	@GetMapping("/detail/{id}")
	public String detail(Model model, @PathVariable int id) {
		Board board = boardSvc.select(id);
		model.addAttribute("board", board);
		
		return "/board/detail";
	}
	
	@GetMapping("/delete/{id}")
	public @ResponseBody String delete(@PathVariable int id) {
		int result = boardSvc.delete(id);
		
		if(result > 0) {
			return Script.locationWithMsg("글을 삭제하였습니다.", "/board/list/1");
		} else {
			return Script.back("글삭제에 실패하였습니다. 다시 시도해 주세요.");
		}
	}
	
	@GetMapping("/updateForm/{id}")
	public String updateForm(Model model, @PathVariable int id) {
		Board board = boardSvc.select(id);
		model.addAttribute("board", board);
		
		return "/board/update";
	}
	
	@PostMapping("/update")
	public @ResponseBody String update(Board board) {
		int result = boardSvc.update(board);
		
		if(result > 0) {
			return Script.location("/board/detail/"+board.getId());
		} else {
			return Script.back("글수정에 실패하였습니다. 다시 시도해 주세요.");
		}
	}
}

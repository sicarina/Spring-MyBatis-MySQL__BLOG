package com.example.blog.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.blog.model.User;
import com.example.blog.service.UserSvc;
import com.example.blog.utils.SHA256;
import com.example.blog.utils.Script;

@Controller
@RequestMapping("/user")
public class UserCtr {
	
	@Autowired
	UserSvc userSvc;
	
	@Value("${file.path}")
	private String resourcePath;
	
	@GetMapping("")
	public String pathRedirect() {
		return "redirect:/user/loginForm";
	}
	
	@GetMapping("/")
	public String pathRedirect2() {
		return "redirect:/user/loginForm";
	}
	
	@GetMapping("/loginForm")
	public String loginForm() {
		return "/user/login";
	}
	
	@PostMapping("/login")
	public @ResponseBody String login(HttpServletRequest request, User user) {
		User returnUser = userSvc.selectUsername(user.getUsername());
		
		String salt = returnUser.getSalt();
		String password = SHA256.getEncrypt(user.getPassword(), salt);
		user.setPassword(password);
		
		User loginedUser = userSvc.login(user);
		
		if(loginedUser != null) {
			HttpSession session = request.getSession();
			session.setAttribute("user", loginedUser);
						
			return Script.location("/board/list/1");
		} else {
			return Script.back("로그인에 실패하였습니다. 다시 시도해 주세요.");
		}
	}
	
	@GetMapping("/joinForm")
	public String joinForm() {
		return "/user/join";
	}
	
	@PostMapping("/duplicate/{username}")
	public @ResponseBody String duplicate(@PathVariable String username) {
		System.out.println("???????????");
		User user = userSvc.selectUsername(username);
		
		System.out.println(user);
		System.out.println("??????????????????????????");
		
		String returnData = null;
		if (user == null) {
			System.out.println("?");
			returnData = "success";
		} else {
			System.out.println("!");
			returnData = "fail";
		}
		
		return returnData;
	}
	
	@PostMapping("/join")
	public @ResponseBody String join(User user) {
		
		String salt = SHA256.getSalt();
		user.setSalt(salt);
		String password = SHA256.getEncrypt(user.getPassword(), salt);
		user.setPassword(password);
		
		int result = userSvc.insert(user);
		
		if(result > 0) {
			return Script.location("/user/loginForm");
		} else {
			return Script.back("회원가입에 실패하였습니다. 다시 시도해 주세요.");
		}
	}
	
	@GetMapping("/info")
	public String info() {
		return "/user/info";
	}
	
	@GetMapping("/info/{username}")
	public @ResponseBody String info(HttpServletRequest request, Model model, @PathVariable String username) {
		User user = userSvc.selectUsername(username);
		
		HttpSession session = request.getSession();
		User userSession = (User)session.getAttribute("user");
		
		if(userSession != null && userSession.getUsername().equals(username)) {
			if(user != null) {
				model.addAttribute("user", user);
				return Script.location("/user/info");
			} else {
				return Script.back("정보를 불러오는 중 실패하였습니다. 다시 시도해 주세요.");
			}
		} else {
			session.invalidate();
			return Script.locationWithMsg("정상적이지 않은 접근입니다.\\n다시 로그인한 후 시도해 주세요.", "/user/loginForm");
		}
		
	}
	
	@PostMapping("/update")
	public @ResponseBody String update(HttpServletRequest request, User user) {
		int result = userSvc.update(user);
		
		HttpSession session = request.getSession();
		User userSession = (User) session.getAttribute("user");
		userSession.setEmail(user.getEmail());
		userSession.setAddress(user.getAddress());
		session.setAttribute("user", userSession);
		
		if(result > 0) {
			return Script.locationWithMsg("사용자 정보를 변경하였습니다.", "/board/list/1");
		} else {
			return Script.back("사용자 정보 변경에 실패하였습니다. 다시 시도해 주세요.");
		}
	}
	
	@GetMapping("/changePasswordForm")
	public String changePasswordForm() {
		return "/user/changePassword";
	}
	
	@PostMapping("/password")
	public @ResponseBody String password(HttpServletRequest request, User user, @RequestParam String newPassword) {
		User newUser = userSvc.selectUsername(user.getUsername());
		String passwordEncrypt = SHA256.getEncrypt(user.getPassword(), newUser.getSalt());
		
		User loginUser = new User();
		loginUser.setUsername(user.getUsername());
		loginUser.setPassword(passwordEncrypt);
		
		User checkedUser = userSvc.login(loginUser);
		
		if(checkedUser != null) {
			checkedUser.setPassword(SHA256.getEncrypt(newPassword, newUser.getSalt()));
			int result = userSvc.updatePw(checkedUser);
			
			if(result > 0) {
				HttpSession session = request.getSession();
				session.invalidate();
				return Script.locationWithMsg("비밀번호 변경이 완료되었습니다.\\n다시 로그인하시기 바랍니다.", "/board/list/1");
			} else {
				return Script.back("비밀번호 변경 실패 : 연결에 실패하였습니다.\\n다시 시도해 주세요.");
			}
		} else {
			return Script.back("비밀번호 변경 실패 : 비밀번호가 정확하지 않거나 연결에 실패하였습니다.\\n다시 시도해 주세요.");
		}
	}
	
	@PostMapping("/upload")
	public @ResponseBody String upload(HttpServletRequest request, @RequestParam("id") int id, @RequestParam("profile") MultipartFile file) {
		UUID uuid = UUID.randomUUID();
		String uuidFileName = uuid + "_" + file.getOriginalFilename();
		
		Path filePath = Paths.get(resourcePath + uuidFileName);
		
		try {
			Files.write(filePath, file.getBytes());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		User user = new User();
		user.setId(id);
		user.setProfile("/upload/" + uuidFileName);

		int result = userSvc.updateProfile(user);
		
		if(result > 0) {
			HttpSession session = request.getSession();
			User userSession = (User) session.getAttribute("user");
			
			userSession.setProfile("/upload/" + uuidFileName);
			session.setAttribute("user", userSession);
			
			return Script.locationWithMsg("프로필 사진 변경이 완료되었습니다.", "/board/list/1");
		} else {
			return Script.back("프로필 사진 변경에 실패하였습니다.\\n다시 시도해 주세요.");
		}
	}
	
	@PostMapping("/upload/delete/{id}")
	public @ResponseBody String uploadDelete(HttpServletRequest request, @PathVariable int id) {
		int result = userSvc.updateProfileNull(id);
		
		if(result > 0) {
			HttpSession session = request.getSession();
			User userSession = (User) session.getAttribute("user");
			
			userSession.setProfile("/img/user.png");
			session.setAttribute("user", userSession);
			
			return Script.locationWithMsg("프로필 사진 변경이 완료되었습니다.", "/board/list/1");
		} else {
			return Script.back("프로필 사진 변경에 실패하였습니다.\\n다시 시도해 주세요.");
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/board/list/1";
	}
	
	@PostMapping("/delete/{id}")
	public @ResponseBody String delete(HttpServletRequest request, @PathVariable int id) {
		int result = userSvc.delete(id);
		
		if(result > 0) {
			HttpSession session = request.getSession();
			session.invalidate();
			
			return Script.locationWithMsg("성공적으로 탈퇴되었습니다.", "/board/list/1");
		} else {
			return Script.back("탈퇴에 실패하였습니다.\\n다시 시도해 주세요.");
		}
	}
	
}

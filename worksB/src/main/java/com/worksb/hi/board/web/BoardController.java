package com.worksb.hi.board.web;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.worksb.hi.board.mapper.BoardMapper;
import com.worksb.hi.board.service.AllTaskBoardVO;
import com.worksb.hi.board.service.BoardRequestVO;
import com.worksb.hi.board.service.BoardService;
import com.worksb.hi.board.service.BoardVO;
import com.worksb.hi.board.service.ScheParticirVO;
import com.worksb.hi.board.service.ScheVO;
import com.worksb.hi.board.service.TaskVO;
import com.worksb.hi.board.service.VoteVO;
import com.worksb.hi.member.service.MemberService;
import com.worksb.hi.member.service.MemberVO;
import com.worksb.hi.project.service.ProjectService;
import com.worksb.hi.project.service.ProjectVO;

// 이진 0818 게시판관리 - 게시글,업무,일정,투표 등록

@Controller
public class BoardController {
	//이진	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ProjectService projectService;
	
	@Autowired
	MemberService memberService;
	
	// 이진
	// 게시글 등록 폼
    @GetMapping("/boardInsert")
	public String BoardInsertForm(@RequestParam int projectId, HttpSession session, Model model) {
		model.addAttribute("projectId", projectId);
		return "project/boardInsert";
	}
    
    // 업무글 등록
    @RequestMapping("taskInsert")
    @ResponseBody
    public int taskInsert(@RequestBody BoardRequestVO brVO) {
    	
    	System.out.println(brVO);
    	// 게시글 등록
    	BoardVO boardVO = brVO.getBoardVO();
    	boardService.insertBoard(brVO.getBoardVO());
    	// 상위 업무 등록
    	TaskVO taskVO = brVO.getTaskVO();
    	taskVO.setPrjBoardId(boardVO.getPrjBoardId());
    	boardService.insertTask(taskVO);
    	
    	// 상위 업무 담당자 등록
    	List<TaskVO> managerList = brVO.getPrjManager();
    	if(managerList != null) {
    		for(int i=0; i < managerList.size(); i++) {
    			TaskVO taskManager = managerList.get(i);
    			//게시글 id
    			taskManager.setPrjBoardId(taskVO.getPrjBoardId());
    			boardService.insertTaskManager(taskManager);
    		}
    	}
    	
    	// 하위 업무 등록
    	List<TaskVO> taskList = brVO.getSubTask();
    	List<TaskVO> subManagerList = brVO.getSubManager();
    	if(taskList != null){
    		TaskVO subtaskVO ;
	    	for(int i=0; i < taskList.size(); i++) {
	    		BoardVO subBoardVO = new BoardVO();
	    		subtaskVO = taskList.get(i);
	    		
	    		// 하위 업무 - 게시글 테이블 저장
	    		subBoardVO.setPrjBoardTitle(subtaskVO.getPrjBoardTitle());
	    		subBoardVO.setMemberId(boardVO.getMemberId());
	    		subBoardVO.setProjectId(boardVO.getProjectId());
	    		subBoardVO.setBoardType(boardVO.getBoardType());
	    		subBoardVO.setInspYn("E2");
	    		boardService.insertBoard(subBoardVO);
	    		
	    		// 하위 업무 - 업무 테이블 저장
	    		subtaskVO.setPrjBoardId(subBoardVO.getPrjBoardId());
	    		subtaskVO.setHighTaskId(taskVO.getTaskId());
	    		boardService.insertTask(subtaskVO);
	    		
	    		// 하위 업무 담당자 boardId 설정
	        	for(int j=0; j<subManagerList.size(); j++) {
	        		TaskVO subManager = subManagerList.get(j);
	        		if(subManager.getPrjBoardId() == i) {
	        			subManager.setPrjBoardId(subBoardVO.getPrjBoardId());
	        		}
	        	}
	    		
	    	}
    	}
    	//하위 업무 담당자 등록
    	if(subManagerList != null) {
    		for(int i=0; i<subManagerList.size(); i++) {
    			boardService.insertTaskManager(subManagerList.get(i));
    		}
    	}
    	int result = boardVO.getProjectId();
    	
    	return result; 
    }
    
	//게시글 등록 - 게시글, 일정, 투표
	@PostMapping("/boardInsert")
	public String boardInsertProcess(BoardVO boardVO, VoteVO voteVO, ScheVO scheVO, HttpSession session) {
		
		MemberVO member = (MemberVO)session.getAttribute("memberInfo");
		String memberId = member.getMemberId();
		
        boardVO.setMemberId(memberId);
		
        String boardType = boardVO.getBoardType();
        
        // 글 prj_project
		boardService.insertBoard(boardVO);
        
		int prjBoardId = boardVO.getPrjBoardId();
		
		// 일정
        if(boardType.equals("C6")) {
        	scheVO.setPrjBoardId(prjBoardId);
        	
        	if(!scheVO.getAlarmDateCode().equals("")) {
        		//알람 시간 구하기
            	String code = scheVO.getAlarmDateCode();
            	Date endDate = scheVO.getEndDate();
            	Calendar cal = Calendar.getInstance();
            	// L1 -> 10분전, L2 -> 1시간 전, L3 -> 1일 전, L4 -> 7일 전
            	cal.setTime(endDate);
            	if(code.equals("L1")) {
            		cal.add(Calendar.MINUTE, -10);
            	} else if(code.equals("L2")) {
            		cal.add(Calendar.HOUR, -1);
            	} else if(code.equals("L3")) {
            		cal.add(Calendar.DATE, -1);
            	} else if(code.equals("L4")) {
            		cal.add(Calendar.DATE, -7);
            	}
            	//알림 시간 등록
            	scheVO.setAlarmDate(cal.getTime());
        	}
        	
        	boardService.insertSche(scheVO);
        	
        }else if(boardType.equals("C7")) {
        	// 투표
        	voteVO.setPrjBoardId(prjBoardId);
        	
        	voteVO.setAnonyVote(voteVO.getAnonyVote() == null ? "A2" : voteVO.getAnonyVote());
        	voteVO.setCompnoVote(voteVO.getCompnoVote() == null ? "A2" : voteVO.getCompnoVote());
        	voteVO.setResultYn(voteVO.getResultYn() == null ? "A2" : voteVO.getResultYn());
        	
        	// 투표글 등록
        	boardService.insertVote(voteVO);
        }
        
		return "redirect:/projectFeed?projectId=" + boardVO.getProjectId();
	}
	
	
	// 일정 조회
	@GetMapping("getScheInfo")
	@ResponseBody
	public ScheVO getScheInfo(ScheVO scheVO) {
		return boardService.getScheInfo(scheVO); 
	}
	
	// 투표 조회
	@GetMapping("getVoteInfo")
	@ResponseBody
	public Map<String, List<VoteVO>> getVoteInfo(@RequestParam("prjBoardId") int prjBoardId) {
		
        Map<String, List<VoteVO>> resultMap = new HashMap<>();
        
        VoteVO voteVO = new VoteVO();
        voteVO.setPrjBoardId(prjBoardId);
        
        // 투표글
        List<VoteVO> voteInfo = boardService.getVoteInfo(voteVO);
        // 투표 항목
        List<VoteVO> voteList = boardService.getVoteList(voteVO);
        
        resultMap.put("voteInfo", voteInfo);
        resultMap.put("voteList", voteList);
        		
        return resultMap;
	}
	
	// 업무 상세 조회
	@GetMapping("getTaskInfo")
	@ResponseBody
	public Map<String, Object> getTaskInfo(@RequestParam("prjBoardId") int prjBoardId) {
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    // 해당 게시글 번호
	    AllTaskBoardVO allTaskBoardVO = new AllTaskBoardVO();
	    allTaskBoardVO.setPrjBoardId(prjBoardId);

	    // 해당 업무 정보
	    List<AllTaskBoardVO> highTask = boardService.getTaskInfo(allTaskBoardVO);
	    // 업무 담당자 리스트
	    List<AllTaskBoardVO> highManager = boardService.getManager(allTaskBoardVO);

	    // 하위 업무
	    // 상위 업무의 업무번호
	    int taskId = boardService.getHighTaskId(allTaskBoardVO);
	    // 해당 업무의 하위 업무 리스트
	    List<AllTaskBoardVO> subTask = boardService.getSubTask(taskId);
	    // 각 하위 업무의 담당자 리스트
	    Map<Integer, List<AllTaskBoardVO>> subManager = new HashMap<>();

	    for (int i = 0; i < subTask.size(); i++) {
	        // 하위 업무 정보
	        AllTaskBoardVO subTaskInfo = subTask.get(i);
	        // 하위 업무의 게시글Id
	        int subTaskPrjBoardId = subTaskInfo.getPrjBoardId();
	        // 객체에 하위 업무의 게시글 Id 설정하기
	        allTaskBoardVO.setPrjBoardId(subTaskPrjBoardId);
	        // 하위 업무의 담당자 정보 조회
	        List<AllTaskBoardVO> subManagerInfo = boardService.getManager(allTaskBoardVO);
	        // 하위 업무 담당자 정보 추가
	        subManager.put(subTaskPrjBoardId, subManagerInfo);
	    }

	    resultMap.put("highTask", highTask);
	    resultMap.put("subTask", subTask);
	    resultMap.put("highManager", highManager);
	    resultMap.put("subManager", subManager);
	    

	    return resultMap;
	}
	
	// 프로젝트 업무탭 - 전체 업무 조회
	@GetMapping("/projectTask")
	public String projectTask(@RequestParam int projectId, Model model, HttpSession session) {
		// 프로젝트 정보
		ProjectVO projectInfo = projectService.getProjectInfo(projectId);
		// 상위 업무 리스트
		List<AllTaskBoardVO> taskList = boardService.getTaskList(projectId);
		
		model.addAttribute("projectInfo", projectInfo);
		model.addAttribute("taskList", taskList);
		
		return "project/projectTask";
	}

/*
	// 업무 수정
	@PostMapping("/updateTask")
	public String updateTask(@RequestBody BoardRequestVO brVO) {
		BoardVO boardVO = brVO.getBoardVO();
		boardService.updateBoard(boardVO);
		
		TaskVO taskVO = brVO.getTaskVO();
		taskVO.setPrjBoardId(boardVO.getPrjBoardId());
		boardService.updateTask(taskVO);
		
		List<TaskVO> managerList = brVO.getPrjManager();
		
		
		return "z";
	}
*/	
	// 업무 삭제
	@PostMapping("/deleteTask")
	@ResponseBody
	public int deleteTask(@RequestParam int prjBoardId){
		TaskVO taskVO = new TaskVO();
		taskVO.setPrjBoardId(prjBoardId);
		int result = taskVO.getProjectId();
		
		boardService.deleteTask(taskVO);
	    
    	
    	return result; 
	}
	
	
	
	//상단 고정 여부 수정
	@GetMapping("/updatePin")
	public String updatePin(BoardVO boardVO) {
		boardService.updatePin(boardVO);
		
		return "redirect:/projectFeed?projectId=" + boardVO.getProjectId();
	}
	
	// 북마크 등록
	@RequestMapping("/insertBookmark")
	@ResponseBody
	public int insertBookmark(BoardVO boardVO) {
		boardService.insertBookmark(boardVO);
		return boardVO.getProjectId();
	}
	
	// 북마크 삭제
	@RequestMapping("/deleteBookmark")
	@ResponseBody
	public int deleteBookmark(BoardVO boardVO) {
		boardService.deleteBookmark(boardVO);
		return boardVO.getProjectId();
	}
	

	// 일정 참가,미참
	@RequestMapping("/sheParticipate")
	@ResponseBody
	public int sheParticipate(ScheParticirVO spVO) {
		return boardService.sheParticipate(spVO);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	//정현
	//프로젝트 일정 캘린더 상세조회
	@GetMapping("getScheBoardInfo")
	@ResponseBody
	public BoardRequestVO getScheBoardInfo(@RequestParam("prjBoardId") int prjBoardId) {
		BoardRequestVO vo = new BoardRequestVO();
		ScheVO scheVO = new ScheVO();
		scheVO.setPrjBoardId(prjBoardId);
		vo.setBoardVO(boardService.getScheBoardInfo(prjBoardId));
		vo.setScheVO(boardService.getScheInfo(scheVO));
		
		MemberVO memberVO = new MemberVO();
		String memberId = vo.getBoardVO().getMemberId();
		memberVO.setMemberId(memberId);
		memberVO = memberService.selectMember(memberVO);
		System.out.println(memberVO);
		vo.setMemberName(memberVO.getMemberName());
		vo.setRealProfilePath(memberVO.getRealProfilePath());
		return vo;
	}
	
	//프로젝트 업무 캘린더 상세조회
	@GetMapping("getTaskBoardInfo")
	@ResponseBody
	public Map<String, Object> getTaskBoardInfo(@RequestParam("prjBoardId") int prjBoardId) {
		//BoardRequestVO vo = new BoardRequestVO();
		Map<String, Object> resultMap = new HashMap<>();
	    
	    // 해당 게시글 번호
	    AllTaskBoardVO allTaskBoardVO = new AllTaskBoardVO();
	    allTaskBoardVO.setPrjBoardId(prjBoardId);

	    // 해당 업무 정보
	    List<AllTaskBoardVO> highTask = boardService.getTaskInfo(allTaskBoardVO);
	    // 업무 담당자 리스트
	    List<AllTaskBoardVO> highManager = boardService.getManager(allTaskBoardVO);

	    // 하위 업무
	    // 상위 업무의 업무번호
	    int taskId = boardService.getHighTaskId(allTaskBoardVO);
	    // 해당 업무의 하위 업무 리스트
	    List<AllTaskBoardVO> subTask = boardService.getSubTask(taskId);
	    // 각 하위 업무의 담당자 리스트
	    Map<Integer, List<AllTaskBoardVO>> subManager = new HashMap<>();

	    for (int i = 0; i < subTask.size(); i++) {
	        // 하위 업무 정보
	        AllTaskBoardVO subTaskInfo = subTask.get(i);
	        // 하위 업무의 게시글Id
	        int subTaskPrjBoardId = subTaskInfo.getPrjBoardId();
	        // 객체에 하위 업무의 게시글 Id 설정하기
	        allTaskBoardVO.setPrjBoardId(subTaskPrjBoardId);
	        // 하위 업무의 담당자 정보 조회
	        List<AllTaskBoardVO> subManagerInfo = boardService.getManager(allTaskBoardVO);
	        // 하위 업무 담당자 정보 추가
	        subManager.put(subTaskPrjBoardId, subManagerInfo);
	    }

	    resultMap.put("highTask", highTask);
	    resultMap.put("subTask", subTask);
	    resultMap.put("highManager", highManager);
	    resultMap.put("subManager", subManager);
	    

	    return resultMap;
	}
}

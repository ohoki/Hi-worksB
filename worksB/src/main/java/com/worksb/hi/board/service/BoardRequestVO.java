package com.worksb.hi.board.service;

import java.util.List;

import lombok.Data;
@Data
public class BoardRequestVO {
	BoardVO boardVO;
	TaskVO taskVO;
	List<TaskVO> subTask;
	List<TaskVO> prjManager;
	//VoteVO voteVO, ScheVO scheVO

}

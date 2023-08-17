package com.worksb.hi.board.mapper;

import com.worksb.hi.board.service.BoardVO;
import com.worksb.hi.board.service.TaskVO;
import com.worksb.hi.board.service.VoteVO;

public interface BoardMapper {
	// 이진
	public int insertBoard(BoardVO boardVO);
	
	public int insertTask(TaskVO taskVO);
	
	public int insertVote(VoteVO voteVO);
	public int insertVoteList(VoteVO voteVO);
}

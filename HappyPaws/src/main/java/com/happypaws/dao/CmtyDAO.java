package com.happypaws.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.happypaws.vo.CmtyCommentVO;
import com.happypaws.vo.CommunityVO;

@Repository
public class CmtyDAO {
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	//커뮤니티 - 리스트 불러오기
	public List<CommunityVO> cmty_list(CommunityVO vo) {
		return mybatis.selectList("CommunityDAO.cmty_list", vo);
	}
	
	//커뮤니티 - 글 갯수 보기
	public int countCmty(CommunityVO vo) {
		return mybatis.selectOne("CommunityDAO.countCmty",vo);
	}	
	
	//커뮤니티 - 상세보기
	public CommunityVO cmty_view(CommunityVO vo) {
		return mybatis.selectOne("CommunityDAO.cmty_view", vo);
	}

	//커뮤니티 - 조회수 update
	public void cmty_count(CommunityVO vo) {
		mybatis.update("CommunityDAO.cmty_count", vo);
	}
	
	//커뮤니티 - 커뮤니티 수정
	public void cmty_update(CommunityVO vo) {
		mybatis.update("CommunityDAO.cmty_update",vo);
	}
	
	//커뮤니티 -글쓰기
	public int cmty_insert(CommunityVO vo) {
		return mybatis.insert("CommunityDAO.cmty_insert", vo);
	}
	
	//커뮤니티 - 글 삭제
	public void cmty_delete(CommunityVO vo) {
		mybatis.update("CommunityDAO.cmty_delete",vo);
	}
	
	//커뮤니티 - 댓글추가
	public void c_addComment(CmtyCommentVO comment) {
		mybatis.insert("CommunityDAO.c_addComment",comment);
	}
	
    //커뮤니티 - 댓글 가져오기
    public List<CmtyCommentVO> c_commentList(CmtyCommentVO comment) {
        return mybatis.selectList("CommunityDAO.c_commentList",comment);
    }
    
    //커뮤니티 - 대댓글추가
    public void c_addReply(CmtyCommentVO comment) {
		mybatis.insert("CommunityDAO.c_addReply",comment);
	}
}

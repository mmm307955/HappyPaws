package com.happypaws.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.happypaws.dao.LostPetDAO;
import com.happypaws.vo.LostPetVO;

@Service("lostPetSVC")
public class LostPetSVC {
    
    @Autowired
    private LostPetDAO lostPetDAO;

    public void insertLostPet(LostPetVO vo) {
        lostPetDAO.insertLostPet(vo);
    }

    public void updateLostPet(LostPetVO vo) {
        lostPetDAO.updateLostPet(vo);
    }

    public void deleteLostPet(LostPetVO vo) {
        lostPetDAO.deleteLostPet(vo);
    }

    public void deleteAllLostPet(LostPetVO vo) {
        lostPetDAO.deleteAllLostPet(vo); // 여기 수정
    }
    
    public LostPetVO getLostPet(LostPetVO vo) {
        return lostPetDAO.getLostPet(vo);
    }

    public List<LostPetVO> getLostPetList(LostPetVO vo) {
        return lostPetDAO.getLostPetList(vo);
    }

    public int countLostPet(LostPetVO vo) {
        return lostPetDAO.countLostPet(vo);
    }

    public void updateLostPetCnt(LostPetVO vo) {
        lostPetDAO.updateLostPetCnt(vo);
    }

    public String getCurrentImage(int lpSeq) {
        return lostPetDAO.getCurrentImage(lpSeq);
    }
}

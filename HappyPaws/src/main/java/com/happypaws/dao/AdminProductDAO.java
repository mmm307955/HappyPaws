package com.happypaws.dao;

import com.happypaws.vo.ProductOptionVO;
import com.happypaws.vo.ProductsVO;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AdminProductDAO {
    private SqlSessionTemplate mybatis;

    public int addProduct(ProductsVO vo) {
        return mybatis.insert("ProductsDAO.addProduct", vo);
    }

    //상품 옵션 추가
    public int addProductOption(ProductOptionVO opt) {
        return mybatis.insert("ProductsDAO.addProductOption", opt);
    }

    //옵션 추가를 위한 아이디 조회
    public int getProductId(ProductsVO vo) {
        return mybatis.selectOne("ProductsDAO.getProductId", vo);
    }

    //상품 삭제
    public int deleteProduct(ProductsVO vo) {
        return mybatis.delete("ProductsDAO.deleteProduct", vo);
    }

    //상품 옵션 삭제
    public int deleteProductOpt(ProductOptionVO opt) {
        return mybatis.delete("ProductsDAO.deleteProductOpt", opt);
    }

    //상품 목록 조회
    public List<ProductsVO> adminProductList(ProductsVO vo) {
        return mybatis.selectList("ProductsDAO.adminProductList", vo);
    }

    //상품 조회
    public ProductsVO productModifyView(ProductsVO vo) {
        return mybatis.selectOne("ProductsDAO.getProduct", vo);
    }

    //상품 목록 - 해당 ID 상품 옵션 조회
    public List<ProductOptionVO> adminProductList(ProductOptionVO opt) {
        return mybatis.selectList("ProductsDAO.adminProductOption", opt);
    }

    //상품 목록 - 모든 옵션 조회
    public List<ProductOptionVO> allOpts(ProductOptionVO opt) {
        return mybatis.selectList("ProductsDAO.allOpts", opt);
    }

    //상품 수 카운트
    public int countProducts(ProductsVO vo) {
        return mybatis.selectOne("ProductsDAO.countProducts", vo);
    }

    //상품 수정
    public int modifyProduct(ProductsVO vo) {
        return mybatis.update("ProductsDAO.modifyProduct", vo);
    }

    //상품 옵션 수정
    public int modifyProduct(ProductOptionVO opt) {
        return mybatis.update("ProductsDAO.modifyProductOption", opt);
    }
}

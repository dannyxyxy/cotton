package org.zerock.wish.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.zerock.wish.vo.WishVO;
import org.springframework.stereotype.Repository;

@Repository
public interface WishMapper {
	List<WishVO> getWishList(@Param("id") String id);
    
    // goods_no로 위시리스트에 이미 존재하는 항목인지 확인하는 메서드
    WishVO getWishByGoodsNo(@Param("id") String id, @Param("goods_no") Long goods_no);
    
    // 사용자 ID와 goods_no로 위시리스트 항목을 추가하는 메서드
    void addWishItem(@Param("id") String id, @Param("goods_no") Long goods_no);
    
    void deleteWishItem(@Param("wish_no") Long wish_no);

    // 상품의 수량 업데이트
    void updateWishTotal(@Param("goods_no") Long goods_no, @Param("total") Integer total);
}

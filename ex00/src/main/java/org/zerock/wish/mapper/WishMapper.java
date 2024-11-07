package org.zerock.wish.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.zerock.wish.vo.WishVO;
import org.springframework.stereotype.Repository;

@Repository
public interface WishMapper {

    // 사용자의 위시리스트 조회
    List<WishVO> getWishListByUserId(@Param("id") String id);

    // 위시리스트 상품 추가
    boolean insertWishItem(WishVO wishVO);

    // 위시리스트에서 상품 제거
    boolean removeWishItem(@Param("goods_no") Long goodsNo, @Param("id") String userId);
}

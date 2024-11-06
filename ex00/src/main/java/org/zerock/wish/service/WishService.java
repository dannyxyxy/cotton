package org.zerock.wish.service;

import java.util.List;
import org.zerock.wish.vo.WishVO;

public interface WishService {
    List<WishVO> getWishListByUserId(String id);
    WishVO getWishByGoodsNo(String id, Long goods_no);
    void addWishItem(String id, Long goods_no);
    void deleteWishItem(Long wish_no);
    void updateWishTotal(Long goods_no, Integer total);
}

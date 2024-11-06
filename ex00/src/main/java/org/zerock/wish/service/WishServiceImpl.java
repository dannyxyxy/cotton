package org.zerock.wish.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.wish.mapper.WishMapper;
import org.zerock.wish.vo.WishVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("wishServiceImpl")
public class WishServiceImpl implements WishService {

    @Setter(onMethod_ = @Autowired)
    private WishMapper mapper;

    @Override
    public List<WishVO> getWishListByUserId(String id) {
        return mapper.getWishList(id);
    }

    @Override
    public WishVO getWishByGoodsNo(String id, Long goods_no) {
        return mapper.getWishByGoodsNo(id, goods_no);
    }

    @Override
    @Transactional
    public void addWishItem(String id, Long goods_no) {
    	  WishVO existingWish = mapper.getWishByGoodsNo(id, goods_no);
          if (existingWish == null) {
              // 상품이 위시리스트에 없을 때 새 항목 추가
              mapper.addWishItem(id, goods_no);
              log.info("위시리스트에 추가됨: " + goods_no);
          } else {
              log.info("이미 위시리스트에 존재하는 상품: " + goods_no);
          }
    }

    @Override
    @Transactional
    public void deleteWishItem(Long wish_no) {
        mapper.deleteWishItem(wish_no);
    }

    @Override
    public void updateWishTotal(Long goods_no, Integer total) {
        mapper.updateWishTotal(goods_no, total);
    }
}

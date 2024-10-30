package org.zerock.goods.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.category.vo.CategoryVO;
import org.zerock.goods.mapper.GoodsMapper;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsPriceVO;
import org.zerock.goods.vo.GoodsSearchVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.util.page.PageObject;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
@Service
@Log4j
@Qualifier("goodsServiceImpl")
public class GoodsServiceImpl implements GoodsService {
	@Setter(onMethod_ = @Autowired)
	private GoodsMapper mapper;
	
	@Override
	public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO goodsSearchVO) {
		// TODO Auto-generated method stub
		pageObject.setTotalRow(mapper.getTotalRow(pageObject, goodsSearchVO));
		
		return mapper.list(pageObject, goodsSearchVO);
	}

	@Override
	public GoodsVO view(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.view(goods_no);
	}
	
	@Override
	public List<GoodsImageVO> imageList(Long goods_no) {
		// TODO Auto-generated method stub
		return mapper.imageList(goods_no);
	}


	@Override
	@Transactional
	public Integer write(GoodsVO vo, List<String> imageFileNames) {
		// TODO Auto-generated method stub
		log.info("goodsVO.goods_no : "+vo.getGoods_no());
		mapper.write(vo);
		Long goods_no = vo.getGoods_no();
	
		mapper.writePrice(vo);
		
		for(String imageName : imageFileNames) {
			GoodsImageVO imageVO = new GoodsImageVO();
			imageVO.setGoods_no(goods_no);
			imageVO.setGoods_img_name(imageName);
			mapper.writeImage(imageVO);
		}
		
		return 1;
	}

	@Override
	public Integer update(GoodsVO vo) {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public Integer delete(GoodsVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<CategoryVO> listCategory(Integer cate_code1) {
		// TODO Auto-generated method stub
		return mapper.getCategory(cate_code1);
	}

	
}

package org.zerock.goods.service;

import java.util.List;

import org.zerock.category.vo.CategoryVO;
import org.zerock.goods.vo.GoodsImageVO;
import org.zerock.goods.vo.GoodsSearchVO;
import org.zerock.goods.vo.GoodsVO;
import org.zerock.util.page.PageObject;

public interface GoodsService {
	
	public List<GoodsVO> list(PageObject pageObject, GoodsSearchVO goodsSearchVO);
	public List<CategoryVO> listCategory(Integer cate_code1);
	public GoodsVO view(Long goods_no);
	public List<GoodsImageVO> imageList(Long goods_no);
	public Integer write(GoodsVO vo, List<String> imageFileNames);
	public Integer update(GoodsVO vo);
	public Integer delete(GoodsVO vo);
	
}

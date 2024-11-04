package org.zerock.goods.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
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
	    log.info("goodsVO.goods_no : " + vo.getGoods_no());

	    // 1. Goods 등록
	    mapper.write(vo);
	    Long goods_no = vo.getGoods_no();
	    
	    // 2. Price 등록
	    mapper.writePrice(vo);
	    
	    // 3. 이미지 등록
	    if (imageFileNames != null && !imageFileNames.isEmpty()) {
	        for (String imageName : imageFileNames) {
	            GoodsImageVO imageVO = new GoodsImageVO();
	            imageVO.setGoods_no(goods_no);
	            imageVO.setGoods_img_name(imageName);
	            log.info("Inserting image for goods_no: " + goods_no + " with image name: " + imageName);
	            mapper.writeImage(imageVO);
	        }
	    } else {
	        log.warn("No images to insert for goods_no: " + goods_no);
	    }
	    
	    return 1;
	}


	@Override
	@Transactional
	public Integer update(GoodsVO vo) {
		// TODO Auto-generated method stub
		mapper.update(vo);
		mapper.updatePrice(vo);
		return 1;
	}
	
//	@Override
//    public String updateImage(Long goods_no, MultipartFile imageFile, String savePath, String deleteFileName) throws Exception {
//        // 새로운 파일 이름 생성 및 저장
//        String newFileName = UUID.randomUUID().toString() + "_" + imageFile.getOriginalFilename();
//        File saveFile = new File(savePath, newFileName);
//        imageFile.transferTo(saveFile);
//
//        // 기존 이미지 삭제
//        File oldFile = new File(savePath, deleteFileName);
//        if (oldFile.exists()) oldFile.delete();
//
//        // DB 업데이트 - 새로운 파일 경로 전달
//        GoodsImageVO vo = new GoodsImageVO();
//        vo.setGoods_no(goods_no);
//        vo.setFileName(newFileName);
//        mapper.updateImage(vo);  // DB 업데이트 실행
//
//        return newFileName;
//    }
//	

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

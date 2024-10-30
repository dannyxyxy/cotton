package org.zerock.goods.vo;

import lombok.Data;

@Data
public class GoodsSearchVO {
	
	private Integer cate_code1;
	private Integer cate_code2;
	private String goods_name;
	private Integer min_price;
	private Integer max_price;
	
	public String getSearchQuery() {
		return ""
				+"cate_code1="+toStr(cate_code1)
				+"&cate_code2="+toStr(cate_code2)
				+"&goods_name="+toStr(goods_name)
				+"&min_price="+toStr(min_price)
				+"&max_price="+toStr(max_price);	
	}
	public String toStr(Object obj) {
		return ((obj==null) ? "" : obj.toString());
	}
	
}

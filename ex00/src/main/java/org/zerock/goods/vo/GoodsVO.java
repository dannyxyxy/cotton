package org.zerock.goods.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
@Data
public class GoodsVO {
	//goods
	private Long goods_no;
	private String goods_name;
	private Integer cate_code1;
	private Integer cate_code2;
	private String cate_name;
	private String image_name;
	private String content;
	private String company;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date product_date;
	
	//goods price
	private Integer price;
	private Integer discount;
	private Integer discount_rate;
	private Integer sale_price;
	private Integer saved_rate;
	private Integer delivary_charge;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sale_start_date;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date sale_end_date;
	
	//실판매가계산기
	public Integer sale_price() {
		if(discount!=0) {
			return price-discount;
		}
		return (price-(price*discount_rate/100))/100*100;	//100원미만절삭
	}
	
}


/**
 * dateTime.js
 * 날짜와 시간에 대한 표시 및 처리
 */
 
 //날짜로 표시 
 //timestamp : LongType의 날짜 정보 데이터
 
 function toDate(timeStamp, separChar){
 	if(!separChar) separChar = "-"
 	let dateObj = new Date(timeStamp); // 시간 객체 생성 ()안에 값이 없으면 현재시간 기준
 	let yy = dateObj.getFullYear(); // 4자리 연도 표시
 	let mm = dateObj.getMonth()+1; // 0~11까지 나와서 +1 해야함 
 	let dd = dateObj.getDate(); // 일 
 	
 	console.log("Date: "+ yy + "-" + mm + "-" + dd);
 	return "" +  // return만 있으면 null로 설정돼서 아무것도 안나옴  
 	yy + separChar +
 	(mm >9 ? "" : "0") + mm + separChar +
 	(dd >9 ? "" : "0") + dd;
 	
 }
 
 //시간으로 표시 
 //timeStamp : Long type의 시간 정보 데이터
 
 function toTime(timeStamp) {
 	let dateObj = new Date(timeStamp);
 	let hh = dateObj.getHours();
 	let mi = dateObj.getMinutes();
 	let ss = dateObj.getSeconds();
 	
 	return "" +
 	 (hh > 9 ? "" : "0") + hh + ":" +
 	 (mi > 9 ? "" : "0") + mi + ":" +
 	 (ss > 9 ? "" : "0") + ss;
 
 }
 
 // 날짜 or 시간 표시 
 // 글 작성일로 부터 24시간이 지나지 않으면 시간 or 날짜
 
function toDateTime(timeStamp) {
 	 //현재 시간 
 	 let today = new Date();  //today --> date 객체
 	 
 	 let dateObj = new Date(timeStamp);  // timeStamp가 Long 타입이 아닐때  
 	 
 	 //얼마나 지났는지 계산
 	 let gap = today.getTime() - dateObj.getTime();  //milliseconds
 	 
 	 console.log(gap);
 	 
 	 //지나간 시간이 24시간 보다 작은 경우 - 시간표시
 	 if(gap < (1000 * 60 * 60 * 24)) { 
 	 	return toTime(timeStamp);
 	 }
 	 else {
 	 	return toDate(timeStamp);
 	 }
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
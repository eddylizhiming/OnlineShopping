package web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import domain.Order;

public class OrderListExcel extends AbstractExcelView{

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		List<Order> orders = (List<Order>) model.get("orders");
		response.setHeader("Content-Disposition", "inline;"
				+ "filename="+ new String("订单列表.xls".getBytes("GBK"),"iso8859-1"));

		HSSFSheet hssfSheet = workbook.createSheet("orders");
		HSSFRow hssfRow = hssfSheet.createRow(0);
		hssfRow.createCell(0).setCellValue(("订单编号"));
		hssfRow.createCell(1).setCellValue("用户名");
		hssfRow.createCell(2).setCellValue("商品编号列表");
		hssfRow.createCell(3).setCellValue("商品数量列表");
		hssfRow.createCell(4).setCellValue("总价");
		hssfRow.createCell(5).setCellValue("生成时间");
		hssfRow.createCell(6).setCellValue("状态");
	
		int rowNum = 1;
		for (Order order : orders){
			hssfRow = hssfSheet.createRow(rowNum);
			hssfRow.createCell(0).setCellValue(order.getOrderId());
			hssfRow.createCell(1).setCellValue(order.getUserId());
			hssfRow.createCell(2).setCellValue(order.getGoodIds());
			hssfRow.createCell(3).setCellValue(order.getAmounts());
			hssfRow.createCell(4).setCellValue(order.getTotal());
			hssfRow.createCell(5).setCellValue(order.getGenerateTime().toString());
			hssfRow.createCell(6).setCellValue(order.getStatus());
			rowNum++;
		}
	}

}

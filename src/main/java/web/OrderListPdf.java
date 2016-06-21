package web;

import java.awt.Color;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.servlet.view.document.AbstractPdfView;
import com.lowagie.text.BadElementException;
import com.lowagie.text.Cell;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Phrase;
import com.lowagie.text.Table;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfWriter;

import domain.Order;

public class OrderListPdf extends AbstractPdfView{

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		List<Order> orders = (List<Order>) model.get("orders");
		response.setHeader("Content-Disposition", "inline;"
				+ "filename="+ new String("用户列表.pdf".getBytes("GBK"),"iso8859-1"));
		
		Table table = new Table(7);
		table.setWidth(100);
		table.setBorder(1);
		table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
		table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
		
		BaseFont baseFont = BaseFont.createFont("STSongStd-Light", "UniGB-UCS2-H", false);
		Font cnFont = new Font(baseFont, 12, Font.NORMAL, Color.RED);
		table.addCell(bulidFontCell("订单编号", cnFont));
		table.addCell(bulidFontCell("用户名", cnFont));
		table.addCell(bulidFontCell("商品编号列表", cnFont));
		table.addCell(bulidFontCell("商品数量列表", cnFont));
		table.addCell(bulidFontCell("总价", cnFont));
		table.addCell(bulidFontCell("生成时间", cnFont));
		table.addCell(bulidFontCell("状态", cnFont));
		
		cnFont = new Font(baseFont, 10, Font.NORMAL, Color.BLACK);
		for (Order order : orders){
			table.addCell(bulidFontCell(order.getOrderId(), cnFont));
			table.addCell(bulidFontCell(order.getUserId(), cnFont));
			table.addCell(bulidFontCell(order.getGoodIds(), cnFont));
			table.addCell(bulidFontCell(order.getAmounts(), cnFont));
			table.addCell(bulidFontCell(String.valueOf(order.getTotal()), cnFont));
			table.addCell(bulidFontCell(order.getGenerateTime().toString(), cnFont));
			table.addCell(bulidFontCell(order.getStatus(), cnFont));
			
		}
		
		document.add(table);
	}

	private Cell bulidFontCell(String text, Font font) throws BadElementException{
		Phrase phrase = new Phrase(text, font);
		Cell cell = new Cell(phrase);
		return cell;
	}
}
